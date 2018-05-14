#include <stdio.h>
#include "code.h"

const int x = 0;

void insert_import(char* file) {
	char buff[256];
	strcpy(buff, "./cpa < ");
	strcpy(buff, file);
	system(buff);
}