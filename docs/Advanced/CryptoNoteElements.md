# CryptoNote Elements

Beldex uses the Monero source code because of the high level of privacy it affords to transactions. Monero is an evolution on the [CryptoNote protocol](https://cryptonote.org/whitepaper.pdf), which uses [ring signatures](#ring-signatures), [stealth addresses](#stealth-addresses), and [RingCT](#ringct), giving users the ability to sign transactions and obfuscate amounts while maintaining plausible deniability.

## Ring Signatures
Ring signatures work by constructing a ring of possible signers to a transaction where only one of the signers is the actual sender. Beldex makes use of ring signatures to obfuscate the true history of transaction outputs. Ring signatures will be mandatory for all Beldex transactions (excluding block reward transactions), and uniquely, a fixed ring-size of ten is enforced on the Beldex blockchain.  This means that each input will spend from one of ten possible outputs, including the true output.


### Ring Signature Size
The size of a ring signature refers to how many mixins are used to construct the ring. Monero currently has an enforced  minimum ring signature size of seven, with six mixins used alongside the real unspent output in a transaction.

The effect of larger ring-sizes has been sparsely studied, however, in [paper 0001](https://lab.getmonero.org/pubs/MRL-0001.pdf) (published by the Monero Research Lab), the effect of differing ring-sizes was analysed versus an attacker who owned a large number of outputs on the blockchain . It was found that higher ring-sizes reduce the timeframe in which a malicious attacker who owned a large number of unspent outputs would be able to perform effective analysis of transactions. Mandating larger ring-sizes also protects against a theoretical attack known as an [EABE/Knacc attack](https://github.com/monero-project/monero/issues/1673#issuecomment-312968452), where a third-party (i.e. an exchange) can perform limited temporal analysis on transactions between two users.

Additionally, Monero has no maximum ring-size enforced by network consensus rules. Many wallets like the Monero GUI wallet cap the ring-size at 26. However, a user is free to manually create a transaction with whatever ring-size they wish, as long as it is above a ring-size of seven. This is problematic since most wallets have a default ring-size of seven.  Increasing a transactions ring-size above seven makes it stand out.  Further, if an individuals transactions  were  to  always use a non-standard ring-size in Monero (ten for example), a passive third-party could analyse the blockchain and infer patterns using temporal analysis.

| transaction hash       | ring size           | tx size[kB]  |
| ------------- |:-------------:| -----:|
|3feaff3f48de0bc4c92ec027236165337b64df404aca098e212c1215e9456697|7|13.47|
|39d484f7c0a2e8f3823a514056d7cb0bf269171cb4582e05955d4c5ee995cad0|7|13.47|
|e08f5a937e725011bedd44075334ae98dcca32749da231c56da1278d49c0a231|7|13.50|
|ab35e69d9cca39219c90df8b2b7aab4a54c82127fb1fbaae65d76357f8f76387|7|13.5|
|6d8ccd56dc2d3eb7de03ba767f0dbf4d5f42ae91e67f4c28f16d6f8b0229c272|10|13.87|

### Beldex Static Ring Size

Beldex improves on both of these problems by statically enforcing ring-sizes, and setting the ring-size to ten. Statically setting the maximum ring-size protects users who construct rings with more than nine mixins and setting the ring-size minimum to ten more effectively prevents an attacker who owns a large number of outputs from discerning the true outputs spent in a ring signature. Larger ring-sizes also increase the default churning effectiveness non-linearly, becoming more effective as ring-sizes grow.

In the current transaction scheme, increasing the ring-size to 10 would lead to a 2.6% increase in the size of the transaction. However, when Bulletproofs are implemented it will account for about a 8 - 13% increase in the size of a transaction. This is because of the overall reduction in transaction size caused by Bulletproofs. Increasing the minimum ring-size may present a problem on a network that lacks architecture to support larger sized transactions, due to the increased overhead. With Beldex however, this burden can be carried by [Master Nodes](../MasterNodes/MNOverview.md) that are incentivised to operate and provide sufficient bandwidth.

## Stealth Addresses
Beldex makes use of stealth addresses to ensure that the true public key of the receiver is never linked to their transaction. Every time a Beldex transaction is sent, a one-time stealth address is created and the funds are sent to this address. Using a Diffie-Hellman key exchange, the receiver of the transaction is able to calculate a private spend key for this stealth address, thereby taking ownership of the funds without having to reveal their true public address.  Stealth addresses provide protection to receivers of transactions and are a core privacy feature in Beldex.

## RingCT
[RingCT](https://lab.getmonero.org/pubs/MRL-0005.pdf) was first proposed by the Monero Research Lab as a way to obfuscate transaction amounts. Current deployments of RingCT use range proofs, which leverage Pedersen commitments to prove that the amount of a transaction being sent is between 0 and 2<sup>64</sup>. This range ensures that only non-negative amounts of currency are sent, without revealing the actual amount sent in the transaction. Recently a number of cryptocurrencies have proposed implementing [bulletproofs](https://eprint.iacr.org/2017/1066.pdf) as a replacement to traditional range proofs in RingCT because of the significant reduction in transaction size. Beldex will utilise bulletproofs, reducing the information that nodes are required to store and relay, thereby improving scalability.
