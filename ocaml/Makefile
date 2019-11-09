.phony: all clean

all:
	@ocamlc -o client unix.cma client.ml #non default module unix
	@ocamlc -o server unix.cma server.ml

clean:
	@rm -f client server server.cmo server.cmi client.cmo client.cmi
