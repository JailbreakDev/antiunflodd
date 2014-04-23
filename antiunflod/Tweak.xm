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
	if (strncmp(address,"23.88.10.4",14) == 0 || strncmp(address,"23.228.204.55",14) == 0) { //compare to malicious ips
		myaddr->sin_addr.s_addr = inet_addr("127.0.0.1"); //if so, set the ip address to localhost

		//alternatively return -1
	}
	return _connectHook(x,(struct sockaddr *)myaddr,len); //return either original or modified connect 
}

%ctor {
MSHookFunction((void *)connect,(void *)$connectHook,(void **)&_connectHook); //hook connect
}