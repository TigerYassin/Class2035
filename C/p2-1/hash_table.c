/*
 Student Name: Yassin Alsahlani
 Date: 11/9/2018

=======================
ECE 2035 Project 2-1:
=======================
This file provides definition for the structs and functions declared in the
header file. It also contains helper functions that are not accessible from
outside of the file.

FOR FULL CREDIT, BE SURE TO TRY MULTIPLE TEST CASES and DOCUMENT YOUR CODE.

===================================
Naming conventions in this file:
===================================
1. All struct names use camel case where the first letter is capitalized.
  e.g. "HashTable", or "HashTableEntry"

2. Variable names with a preceding underscore "_" will not be called directly.
  e.g. "_HashTable", "_HashTableEntry"

  Recall that in C, we have to type "struct" together with the name of the struct
  in order to initialize a new variable. To avoid this, in hash_table.h
  we use typedef to provide new "nicknames" for "struct _HashTable" and
  "struct _HashTableEntry". As a result, we can create new struct variables
  by just using:
    - "HashTable myNewTable;"
     or
    - "HashTableEntry myNewHashTableEntry;"

  The preceding underscore "_" simply provides a distinction between the names
  of the actual struct defition and the "nicknames" that we use to initialize
  new structs.
  [See Hidden Definitions section for more information.]

3. Functions, their local variables and arguments are named with camel case, where
  the first letter is lower-case.
  e.g. "createHashTable" is a function. One of its arguments is "numBuckets".
       It also has a local variable called "newTable".

4. The name of a struct member is divided by using underscores "_". This serves
  as a distinction between function local variables and struct members.
  e.g. "num_buckets" is a member of "HashTable".

*/

/****************************************************************************
* Include the Public Interface
*
* By including the public interface at the top of the file, the compiler can
* enforce that the function declarations in the the header are not in
* conflict with the definitions in the file. This is not a guarantee of
* correctness, but it is better than nothing!
***************************************************************************/
#include "hash_table.h"


/****************************************************************************
* Include other private dependencies
*
* These other modules are used in the implementation of the hash table module,
* but are not required by users of the hash table.
***************************************************************************/
#include <stdlib.h>   // For malloc and free
#include <stdio.h>    // For printf


/****************************************************************************
* Hidden Definitions
*
* These definitions are not available outside of this file. However, because
* the are forward declared in hash_table.h, the type names are
* available everywhere and user code can hold pointers to these structs.
***************************************************************************/
/**
 * This structure represents an a hash table.
 * Use "HashTable" instead when you are creating a new variable. [See top comments]
 */
struct _HashTable {
  /** The array of pointers to the head of a singly linked list, whose nodes
      are HashTableEntry objects */
  HashTableEntry** buckets;

  /** The hash function pointer */
  HashFunction hash;

  /** The number of buckets in the hash table */
  unsigned int num_buckets;
};

/**
 * This structure represents a hash table entry.
 * Use "HashTableEntry" instead when you are creating a new variable. [See top comments]
 */
struct _HashTableEntry {
  /** The key for the hash table entry */
  unsigned int key;

  /** The value associated with this hash table entry */
  void* value;

  /**
  * A pointer pointing to the next hash table entry
  * NULL means there is no next entry (i.e. this is the tail)
  */
  HashTableEntry* next;
};


/****************************************************************************
* Private Functions
*
* These functions are not available outside of this file, since they are not
* declared in hash_table.h.
***************************************************************************/
/**
* createHashTableEntry
*
* Helper function that creates a hash table entry by allocating memory for it on
* the heap. It initializes the entry with key and value, initialize pointer to
* the next entry as NULL, and return the pointer to this hash table entry.
*
* @param key The key corresponds to the hash table entry
* @param value The value stored in the hash table entry
* @return The pointer to the hash table entry
*/
static HashTableEntry* createHashTableEntry(unsigned int key, void* value) {
  //malloc memory for HashTableEntry
  HashTableEntry * myHashTableEntry = (HashTableEntry *) malloc(sizeof(HashTableEntry));
  //assigning the right variables
  myHashTableEntry ->key = key;
  myHashTableEntry->value = value;

  return myHashTableEntry;
}

/**
* findItem
*
* Helper function that checks whether there exists the hash table entry that
* contains a specific key.
*
* @param hashTable The pointer to the hash table.
* @param key The key corresponds to the hash table entry
* @return The pointer to the hash table entry, or NULL if key does not exist
*/
static HashTableEntry* findItem(HashTable* hashTable, unsigned int key) {
      //TODO Must check if HashTable has given key
      unsigned int hashedKey = hashTable->hash(key); //Hashed key
      HashTableEntry * ptr = hashTable->buckets[hashedKey]; //getting value at key
      while (ptr) {
        if (key == ptr->key) {
          return ptr;
        }
        ptr = ptr->next;
      }

      return NULL;
}

/****************************************************************************
* Public Interface Functions
*
* These functions implement the public interface as specified in the header
* file, and make use of the private functions and hidden definitions in the
* above sections.
****************************************************************************/
// The createHashTable is provided for you as a starting point.
HashTable* createHashTable(HashFunction hashFunction, unsigned int numBuckets) {
  // The hash table has to contain at least one bucket. Exit gracefully if
  // this condition is not met.
  if (numBuckets==0) {
    printf("Hash table has to contain at least 1 bucket...\n");
    exit(1);
  }

  // Allocate memory for the new HashTable struct on heap.
  HashTable* newTable = (HashTable*)malloc(sizeof(HashTable));

  // Initialize the components of the new HashTable struct.
  newTable->hash = hashFunction;
  newTable->num_buckets = numBuckets;
  newTable->buckets = (HashTableEntry**)malloc(numBuckets*sizeof(HashTableEntry*));

  // As the new buckets contain indeterminant values, init each bucket as NULL.
  unsigned int i;
  for (i=0; i<numBuckets; ++i) {
    newTable->buckets[i] = NULL;
  }

  // Return the new HashTable struct.
  return newTable;
}

void destroyHashTable(HashTable* hashTable) {
  free(hashTable->buckets); //Freeing everything inside of the buckets
    //must cycle through the Array of buckets and free each entry one by one using the hashedKey
  free(hashTable);    //Freeing the pointer


}

void* insertItem(HashTable* hashTable, unsigned int key, void* value) {
      //TODO
      unsigned int hashedKey = hashTable->hash(key); //Hashed key
      HashTableEntry * ptr =  findItem(hashTable, key); //Pass the variable via the findItem method

      //check if the item already exists
      if (ptr != NULL) {
        void * temp = ptr -> value;  //keeping track of the former value
        ptr -> value = value; //updating
        return temp;
      }

        //check if it doesn't exist already and check if the table is empty or nothing
        /*
          -Check if doesn't exist
          -Check if table is empty or Not
        */
      else if (ptr == NULL) {
        HashTableEntry *myHashTableEntry = createHashTableEntry(key, value);
        if (hashTable -> buckets[hashedKey] == NULL) {
          hashTable->buckets[hashedKey] = myHashTableEntry;
          return NULL;
        }

        else{
              HashTableEntry *ptr2 = hashTable->buckets[hashedKey];
              while(ptr2 !=NULL){ //Will keep on loop through as long as its not null
                if (ptr2->next == NULL) {
                  ptr2-> next = myHashTableEntry;

                  return NULL; //get out of the function
                }
                //TODO update the value of the ptr2
                ptr2 = ptr2->next;
              }

            }

      }


}

void* getItem(HashTable* hashTable, unsigned int key) {
  unsigned int hashedKey = hashTable->hash(key); //Hashed key
  HashTableEntry * ptr =  findItem(hashTable, key); //Pass the variable via the findItem method

  if (ptr == NULL) {
    return NULL;
  }
  return ptr -> value;

}




void* removeItem(HashTable* hashTable, unsigned int key) {

  unsigned int hashedKey = hashTable->hash(key); //Hashed key
  HashTableEntry * ptr =  findItem(hashTable, key); //Pass the variable via the findItem method

  HashTableEntry* ptr2 = hashTable->buckets[hashedKey];

  if (ptr == NULL) { //checks if item exists
     return NULL;
  }
  else if (ptr != NULL){
    void* tempVal = ptr->value;

    //TODO Check if that item is the first or only one in its bucket
    if (ptr2 == ptr2) {
      if (ptr->next ==NULL) {
        hashTable->buckets[hashedKey] = NULL;
        free(ptr);
        return tempVal;
      }


      else if (ptr -> next != NULL) {
        hashTable->buckets[hashedKey] = ptr->next;
        free(ptr);
        return tempVal;
      }
}
      else if (ptr2) {
        while (ptr2) {
          if (ptr2->next->key == key) {
            ptr2->next = ptr->next;
            free(ptr);
            return tempVal;
          }
        }

    }
  }

}

void deleteItem(HashTable* hashTable, unsigned int key) {
//TODO start from key and free the entry at key

removeItem(hashTable, key);
}
