#!/bin/perl

use strict;
use warnings;
use IO::Socket::INET;
use Coro; #coroutine (threads are not lightweight)

main(); #run main

sub main{
    #config section
    my $host = '127.0.0.1';
    my $port = '1234';
    my $prot = 'tcp';

    #auto-flush on socket
    $| = 1;
    
    #create listening socket
    my $socket = new IO::Socket::INET(
        LocalHost => $host,
        LocalPort => $port,
        Proto => $prot,
        Listen => 5,
        Reuse => 1
        );
    #error handling
    die "cannot create socket $!\n" unless $socket;

    #print
    print "server started: ${host}:${port}\n";

    #run server
    while(1){
        #accept connection
        my $client = $socket->accept();

        #handle connection
        print("start coroutine\n");
        async{
            handle_conn($_[0]);
            #cede on exit
        } $client;
        cede; #yield to coroutine, does not actually create parallelism here :-/
        #multithreading seems to be an issue in perl: http://synflood.at/blog/index.php?/archives/791-Rebooting-the-baconbird-project.html
        #(I stop here...)
    }

    #close server
    $socket->close();
}


sub handle_conn{
    #rename arguments
    my $client = $_[0];
    
    #print info about client
    my $cl_ip = $client->peerhost();
    my $cl_port = $client->peerport();
    print "client: ${cl_ip}:${cl_port}\n";
    
    #ignore client data
    
    #send data
    $client->send("server");
    
    #shutdown
    shutdown($client, 1);
}

