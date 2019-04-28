# Infinite Staking Primer

##Outline For Existing Master Node Participants and Operators

Infinite Staking is an incremental upgrade on the existing staking process that is currently available on the Beldex network (currently active in Hardfork 10: Bulletproofs, introduced in Hardfork 9: Master Nodes). With Infinite Staking, Master Nodes do not expire and funds remain locked until a contributor or operator explicitly requests the Master Node to unlock the funds.

Since Infinite Staking is an incremental upgrade, most of the steps necessary to register and participate in a Master Node remain the same. A quick overview for the new staking process is summarised for quick grokking. (Yes, grokking is a word. Google it.)

## Updated Staking Process and Commands

### Operators
Operators will still use the following commands when setting up a Master Node. The commands are as follows:

- `prepare_registration` in the daemon that is running in `--master-node` mode.
    
- `register_master_node` with the command returned by the daemon. **Auto staking** is no longer an option.

### Contributors
Two new commands have been added to stop your Master Node from staking, and both the contributor and operator can execute these commands:

- `stake <master node key>` to contribute to the node. **Auto staking** is no longer an option.

### Operators & Contributors (When Master Node Active)
Two new commands have been added to stop your Master Node from staking, both the contributor and operator can execute these commands:

- **(Optional)** `print_locked_stakes` to preview all the current wallet’s transactions that are locked in a Master Node or blacklisted on the network.
    
- `request_stake_unlock <master node key>` to request to unlock the stake in 15 days (10800 blocks).

## Unlocking Stakes & Deregistration

Master Nodes will continually receive block rewards indefinitely until a stake is unlocked or the Master Node becomes deregistered. Unlocking is available via the `request_stake_unlock <master node key>` in the command line wallet. Once the unlock is requested and the request is included in a block in the blockchain, the Master Node will then expire in 15 days (10800 blocks) and the funds will become unlocked after expiry.

In pooled nodes, any contributor that requests the stake to unlock will schedule the Master Node for expiration. All locked stakes in that Master Node will be unlocked in 15 days (10800 blocks). Once the unlock is requested, this process can not be undone or prolonged. Master Node participants will continue receiving rewards until expiration.

Under the new system, deregistrations can be issued at any point during the active lifecycle of the Master Node. This is inclusive of the time period during which the Master Node is scheduled for expiry. Getting deregistered removes your Master Node from the network and your stakes are placed into a list of blacklisted transactions. Blacklisted transactions are locked and unspendable for 30 days (21600 blocks) from the block in which the Master Node was deregistered.

Receiving a deregistration after participants have already requested the stake to unlock overrides the 15 day (10800 blocks) unlock time, and resets the unlock time to 30 days (21600 blocks).

## Minimum Contribution Rules

Infinite Staking introduces new limitations on the number of transactions that can be contributed to a Master Node, changing the minimum contribution rules for participating in the Master Node. 

Master Nodes accept at most 4 contributions, meaning the minimum contribution to a Master Node becomes:

<center>![Contribution](../assets/contribution.svg)</center>

In a pooled Master Node with reserved spots, the Minimum Contribution must be either the Reserved Amount or the Contribution determined by the above equation, whichever is larger.

<center>![Min Contribution](../assets/mincontribution.svg)</center>

A simplistic example being, if the staking requirement is 24,000 BDX then if,

-   Operator contributes 50% of the requirement (12,000 BDX)

-   The next contributor must contribute at least (⅓ * 12,000) BDX i.e. 4000 BDX to become a participant.

-   If this contributor had reserved a spot for more than 4000 BDX, their Minimum Contribution would be that amount.
    
There are rules in the client software in place to stop users from irreversibly funding a Master Node into an invalid state.

## Staking Changes

Users are no longer allowed to stake on behalf of another participant in the Master Node. All contributions for a participant must come from the same wallet address as the one specified in the Master Node.

## Developer API Changes

### get_master_nodes

Updated/newly added fields:

- `requested_unlock_height` - The height at which the stakes will unlock and the Master Node will expire. 
- `contributors`
     - `locked_contributions` - An array of each contribution from the contributor that is locked.
         - `key_image` - A string representation of the locked key image (stake).
         - `key_image_pub_key` - A string representation of the public key component of a key image.
         - `amount` - The amount of Beldex locked in this contribution.

### get_master_node_blacklisted_key_images

Retrieve a list of blacklisted transactions from deregistered Master Nodes on the network.

- `blacklist` - An array of each blacklisted transaction from deregistered Master Nodes
     - `key_image` - A string representation of the blacklisted key image (stake).
     - `unlock_height` - The height at which the stake can be spent again.
