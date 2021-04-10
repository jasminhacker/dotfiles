all:
	touch regular
	mkdir directory
	ln -s regular link
	touch multihardlink
	ln multihardlink hardlink
	mkfifo fifo
	timeout 1 nc -lkU socket || true
	# for devices see /dev
	ln -s missing orphan
	touch suid
	chmod u+s suid
	touch sgid
	chmod g+s sgid
	touch capability
	sudo setcap cap_net_raw+eip capability
	mkdir sticky_ow
	chmod +t sticky_ow
	chmod o+w sticky_ow
	mkdir sticky
	chmod +t sticky
	mkdir ow
	chmod o+w ow
	touch exec
	chmod +x exec
	touch archive.tar
	touch image.jpg
	touch audio.aac

clean:
	rm -rf directory sticky_ow sticky ow
	rm -f fifo capability link hardlink multihardlink regular socket orphan sgid suid exec archive.tar image.jpg audio.aac
