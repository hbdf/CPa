// C program for linked list implementation of stack
// https://www.geeksforgeeks.org/stack-data-structure-introduction-program/
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

// A structure to represent a stack
typedef struct StackNode{
    int data;
    struct StackNode* next;
} StackNode;

StackNode* newNode(int data){
    StackNode* stackNode = (StackNode*) malloc(sizeof(StackNode));
    stackNode->data = data;
    stackNode->next = NULL;
    return stackNode;
}

int isEmpty(StackNode *root){
    return !root;
}

void push(StackNode** root, int data){
    StackNode* stackNode = newNode(data);
    stackNode->next = *root;
    *root = stackNode;
}

int pop(StackNode** root){
    if (isEmpty(*root))
        return INT_MIN;
    StackNode* temp = *root;
    *root = (*root)->next;
    int popped = temp->data;
    free(temp);

    return popped;
}

int top(StackNode* root){
    if (isEmpty(root))
        return INT_MIN;
    return root->data;
}