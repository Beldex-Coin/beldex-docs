# Multisignature
In cryptocurrencies, multisig feature allows you to sign a transaction with more than one private key. Funds protected with multisig can only be spent by signing with M-of-N keys.

| **Use Case**                                                           	| **Scheme**   	| **Example**                                                                                                                                            	|
|---------------------------------------------------------------------	|----------	|----------------------------------------------------------------------------------------------------------------------------------------------------	|
| Shared Account                                                      	| (1-of-2) 	| Both husband and wife individually have full access to their funds.                                                                                	|
| [Consensus Account](../Wallets/CliWallet/2of2Multisig.md)           	| (2-of-2) 	| Both husband and wife must agree to spend their funds.                                                                                             	|
| [Threshold account](../Wallets/CliWallet/2of3Multisig.md)           	| (2-of-3) 	| An escrow service is involved as an independent 3rd party, to co-sign with either the seller, or with the buyer, if seller and buyer do not agree. 	|
| [Secure account](../Wallets/CliWallet/2of3Multisig.md)              	| (2-of-3) 	| A single owner controls all 3 keys but secures them via a different means to diversify risks.                                                      	|
| [Arbitrary threshold account](../Wallets/CliWallet/MofNMultisig.md) 	| (M-of-N) 	| Some cryptocurrencies provide full flexibility on the number of signers.                                                                           	|

## Beldex Multisignature

Beldex doesn't directly implement multisignatures (at least not in a classical sense). Monero emulates the feature by secret splitting and Beldex has brought this code from Moneros code base.

Transactions are still signed with a single spend key. The spend key is a sum of all N private keys. The rationale for such design is to decouple multisig from ring signatures.

Let's consider the 2-of-3 scheme. We have 3 participants. Each participant is granted exactly 2 private keys in a way that pairs do not repeat between participants. This way any 2 participants together have all 3 private keys required to create the private spend key.

Multi-signing is a wallet-level feature. There is no way to learn from the blockchain which transactions were created using multiple signatures.

It is also worth noting in Beldex there is no multisig addresses as such. The Address structure does not care how the underlying private spend key got created.

In Beldex, multisignature is supported for M of N participants making any combination of signers possible.

After multisig wallet setup every participant ends up knowing the public address and private view key. This is necessary for participants to recognize and decipher transactions they are supposed to co-sign.

## Guides

| Guide                                                                      	| Description                               	|
|----------------------------------------------------------------------------	|-------------------------------------------	|
| [2-of-2 Multisigniture Wallet Setup](../Wallets/CliWallet/2of2Multisig.md) 	| Setup Guide for a 2 of 2 Multsig Wallet.  	|
| [2-of-3 Multisigniture Wallet Setup](../Wallets/CliWallet/2of3Multisig.md) 	| Setup Guide for a 2 of 3 Multsig Wallet.  	|
| [M-of-N Multisig Setup Guide](../Wallets/CliWallet/MofNMultisig.md)        	| Setup Guide for a M of N Multisig Wallet. 	|