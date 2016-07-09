//
//  CryptoLib.cpp
//  VeraCryptoLib
//
//  Created by Yury Ramanchuk on 7/7/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#include "CryptoLib.h"

//    http://stackoverflow.com/questions/20365005/c-xor-encryption
void xor_crypt(const char *key, int key_len, char *data, int data_len)
{
    for (int i = 0; i < data_len; i++)
        data[i] ^= key[ i % key_len ];
}

