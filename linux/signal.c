#include <signal.h>
#include <stdio.h>

void signal_handler(int signo)
{
    switch(signo)
    {
    case SIGUSR1:
        printf("signal SIGUSR1 is received\n");
        break;
        
    case SIGINT:
        printf("signal SIGINT is received\n");
        break;
        
    case SIGKILL:
    case SIGSTOP:
        // these two signal can't be received
        break;
        
    default:
        printf("unknown signal %i is received\n", signo);
        break;
    }
}

int main(int argc, char* argv[])
{
    if (signal(SIGUSR1, signal_handler) == SIG_ERR)
        printf("SIGUSR1 register failed\n");
        
    if (signal(SIGINT, signal_handler) == SIG_ERR)
        printf("SIGINT register failed\n");
        
    return 0;
}


// when compiled, then use "kill -USR1/SIGINT/SIGKILL pid" to send signal