#!/bin/perl

use strict;
use warnings;
use IO::Socket::INET;

main(); #run main

sub main{
    #config section
    my $host = '127.0.0.1';
    my $port = '1234';
    my $prot = 'tcp';

    #auto-flush on socket
    $| = 1;

    #socket
    my $socket = new IO::Socket::INET(
        PeerHost => $host,
        PeerPort => $port,
        Proto => $prot,
        );
    #check
    die "cannot connect to server $!\n" unless $socket;

    #send data (should be ignored)
    $socket->send("perl client");

    #notify server that request has been sent
    shutdown($socket, 1);

    #server answer
    my $response = "";
    $socket->recv($response, 1024);
    print "server: ${response}\n";

    #shutdown
    $socket->close();
}

