#!/bin/sh

TYPE="${BLOCK_INSTANCE:-mem}"

awk -v type=$TYPE '
/^MemTotal:/ {
	mem_total=$2
}
/^MemFree:/ {
	mem_free=$2
}
/^Buffers:/ {
	mem_free+=$2
}
/^Cached:/ {
	mem_free+=$2
}
/^SwapTotal:/ {
	swap_total=$2
}
/^SwapFree:/ {
	swap_free=$2
}
END {
	# full text
	if (type == "swap")
		free=(swap_total-swap_free)/1024/1024
	else
		free=mem_free/1024/1024
		total=mem_total/1024/1024

	printf("%.1fG\n", free)
	printf("%.1fG\n", free)
	if (free/total < 0.1)
		print "#cc241d"
	else if (free/total < 0.25)
		print "#fabd2f"
	else
		#print "#8ec07c"
}
' /proc/meminfo
