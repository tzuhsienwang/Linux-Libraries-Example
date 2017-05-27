#include <stdlib.h>
#include <stdio.h>
#include <dlfcn.h>

#if defined(STATIC) || defined(DYNAMIC)
#include "sum.h"
#endif

int main(int argc, char **argv) {
#if defined(DL)
	void *handle;
	double (*sum)(double, double);
	char *error;

	handle = dlopen("./lib/.build/libsum.so.1", RTLD_LAZY);
	if (!handle) {
		fputs(dlerror(), stderr);
		exit(1);
	}

	sum = dlsym(handle, "sum");
	if ((error = dlerror()) != NULL) {
		fputs(error, stderr);
		exit(1);
	}
#endif

	double a = 2.6, b = 4.2, c = 0;
	c = sum(a, b);
	printf("%.1f + %.1f = %.1f\n", a, b, c);

#if defined(DL)
	dlclose(handle);
#endif
	return 0;
}
