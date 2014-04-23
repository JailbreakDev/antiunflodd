/*
 antiunflod is a tweak that blocks connections to the malicious IPs (actually redirects the request to 127.0.0.1)
 Copyright (C) 2014  Jack (sharedRoutine)
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

 */

#import <substrate.h>
#import <netinet/in.h>
#import <arpa/inet.h>

//declare the function
static int (*_connectHook)(int x, const struct sockaddr *addr, socklen_t len); //original arguments

//implement the hook function
static int $connectHook(int x, const struct sockaddr *addr, socklen_t len) {
	struct sockaddr_in *myaddr = (struct sockaddr_in *)addr; //get sockaddr_in * from argument
	char address[INET_ADDRSTRLEN]; //store the ip address here
	inet_ntop(AF_INET,&(myaddr->sin_addr),address,INET_ADDRSTRLEN); //get ip address and store it in address variable
	if (strncmp(address,"23.88.10.4",10) == 0 || strncmp(address,"23.228.204.55",13) == 0) { //compare to malicious ips
		myaddr->sin_addr.s_addr = inet_addr("127.0.0.1"); //if so, set the ip address to localhost
		//alternatively return -1
	}
	return _connectHook(x,(struct sockaddr *)myaddr,len); //return either original or modified connect 
}

%ctor {
MSHookFunction((void *)connect,(void *)$connectHook,(void **)&_connectHook); //hook connect
}