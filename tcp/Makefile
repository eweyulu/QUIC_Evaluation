SRC:=tcp2_server_2911.log


ALL:=one-way-pkt-sz.txt \
	tput-over-time_server29.txt	\
	tput-over-time_server29.pdf


.PHONY: all clean

all: $(ALL)

clean:
	@rm -f $(ALL)


one-way-pkt-sz.txt: $(SRC)
	@grep -v '^!' $< > $@


# Inter-packet arrival times and packet sizes.
tput-over-time_server29.txt: one-way-pkt-sz.txt
	@awk 'BEGIN{OFMT="%f"} {print $$2, $$4}' $< | awk 'NR>1 && NR<34839' > $@


tput-over-time_server29.pdf: plot.gp tput-over-time_server29.txt
	@gnuplot						 \
		-e 'IN_FILE="$(word 2, $^)"' \
		-e 'OUT_FILE="$@"' 			 \
		$(word 1, $^)

