load="$(cut -d ' ' -f1 /proc/loadavg)"
cpus="$(nproc)"

# full text
echo "$load"

# short text
echo "$load"

# color if load is too high
awk -v cpus=$cpus -v cpuload=$load '
    BEGIN {
        if (cpus <= cpuload) {
            print "#cc241d";
            # exit 33;
		} else if (cpus <= cpuload*0.8) {
            print "#fabd2f";
		} else {
            #print "#8ec07c";
		}
    }
'
