#Cryptoeconomics

## Block Rewards

A block reward is the reward created when a new block has been generated. The reward is distributed to the peers in the network that helped facilitate the generation of the block. In most cases, the [miners](../Mining/MiningOverview.md) are the individuals who receive this reward as they collect and write transactions into blocks. 

### Beldex Block Reward
The Beldex Block Reward is generated in a similar manner to most proof-of-work cryptocurrencies. Miners use proof-of-work to generate a block and then a reward is released to the network. The reward is then distributed not only distributed to the Miner but to a Master Node Operator and the Governance pool.

The amount of Beldex rewarded `BR` to the network at each block height `h` follows the following equation:

<center>![Block Reward Formula](../assets/blockreward.svg)</center>

The Beldex block reward went from being calculated in terms of the circulating supply with an emission speed factor of 28, to be derived from the block height.

### Block Reward Split

As Master Node's went live on 23rd of April, 2019, at block 56240 the addition of a Block Reward split was required to financially incentivise [Master Node](../MasterNodes/MNOverview.md) Operators to maintain and run Master Nodes. During the fork on the 23rd of April, 2019, the Block Reward was hard coded to split the reward as follows:


|Party|Percent of Reward|
|------|-------|
|Master Nodes|90%|
|Miners|10%|

#### Mining Reward
As well as collecting transactions fees, 10% of the block reward is awarded to the miner that constructs the block. We have set the miner reward low as we are currently working on POS and the Beldex will not be minable in future.

#### Master Node Reward
The second output in each block (90% of total reward) goes to a [Master Node](../MasterNodes/MNOverview.md), or two Master Nodes if a relay is selected. Master Nodes are rewarded based on the time since they last received a reward (or time since they registered), with a preference for nodes that have been waiting longer. Each time a Master Node registers with the network it assumes the last position in the queue. If the Master Node maintains good service and is not ejected from the queue by a [swarm flag](../Advanced/SwarmFlagging.md), it slowly migrates to the higher positions in the queue. Nodes at or near the front of the queue are eligible for a reward, and once awarded, the node again drops to the last position in the queue and begins slowly working its way back up.
