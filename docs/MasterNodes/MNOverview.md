
# Master Nodes Overview

Although Beldex implements novel changes on top of the [CryptoNote protocol](../Advanced/CryptoNoteElements.md) ([ASIC Resistance](../MasterNodes/Mining/ASICResistance.md), [Dynamic Block Size](../Advanced/DynamicBlockSize.md) & [Static Ring Signatures](/Advanced/CryptoNoteElements/#ring-signatures)), much of Beldex’s networking functionality and scalability is enabled by a set of incentivised nodes called Master Nodes.  To operate a Master Node, an operator [time-locks a significant amount of Beldex](../MasterNodes/StakingRequirement.md) and provides a minimum level of bandwidth and storage to the network. In return for their services, Beldex Master Node operators receive a portion of the block reward from each block.

The resulting network provides market-based resistance to Sybil attacks, addressing a range of problems with existing mixnets and privacy-centric services. This resistance is based on supply and demand interactions which help prevent single actors from having a large enough stake in Beldex to have a significant negative impact on the second-layer privacy services Beldex provides. [DASH](https://github.com/dashpay/dash/wiki/Whitepaper) first theorised that Sybil attack resistant networks can be derived from cryptoeconomics. As an attacker accumulates Beldex, the  circulating supply decreases, in turn applying demand-side pressure, driving the price of Beldex up. As this continues, it
becomes increasingly costly for additional Beldex to be purchased, making the attack prohibitively expensive.

To achieve this economic protection, Beldex encourages the active suppression of the circulating supply. In particular, the [emissions curve](../Advanced/Cryptoeconomics.md) and [collateral requirements](../MasterNodes/StakingRequirement.md) must be designed to ensure enough circulating supply is locked and reasonable returns are provided for operators to ensure Sybil attack resistance

## Master Node Activities

Right now Master Nodes are full nodes on the Beldex network. Full nodes become Master Nodes when the owner [locks the required amount of Beldex](../MasterNodes/StakingRequirement.md) for 30 days (2 days on testnet) and submits a registration transaction. Once accepted by the network, the Master Node is eligible to win [block rewards](../Advanced/Cryptoeconomics.md). Multiple participants can be involved in one Master Node and can have the reward automatically distributed.

## Guides & Resources

| **Guide/Resource**                                                                                                       	| **Description**                                                                                                                                   	|
|--------------------------------------------------------------------------------------------------------------------------	|---------------------------------------------------------------------------------------------------------------------------------------------------	| 
| **[Setting up Master Node](../MasterNodes/MNFullGuide.md)**                                                            	| How to host and maintain a Master Node using the [CLI wallet](/Wallets/WalletsOverview/#command-line-interface-wallet-cli). |
| **[Updating your Master Node](../MasterNodes/UpdateGuide.md)**                                                          | How to update your Master Node version.|
| **[Master Node RPC](../Developer/MNRPCGuide.md)**                                                                       	| How to use JSON 2.0 RPC Calls with Master Nodes.                                                                                                 	|
| **[Active Master Node List](http://explorer.beldexcoin.com)**                                                               	| Beldex Block explorer showing the current Master Node Pubkeys.                                                                                   