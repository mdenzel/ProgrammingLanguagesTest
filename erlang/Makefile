.phony: all clean

all:
	erlc server.erl
	erlc client.erl

server:
	@erlc server.erl
	@erl -noshell -s server start -s init stop

client:
	@erlc client.erl
	@erl -noshell -s client start -s init stop

clean:
	@rm -f client.beam server.beam

