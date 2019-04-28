# Staking Requirement

A stake involves holding a specific cryptocoin in a wallet for a particular period of time. A staking requirement is the minimum amount of said cryptocoin that is required to stake.

## Master Node Staking Requirement
A Beldex staking Requirement is the collateral requirement an operator stakes through a time-locked output, which can be unlocked as per the contributor's request. Upon a request to unlock the funds they will stay locked for an additional 15 days where the contributor will still receive rewards. In the extra field of the transaction, the Master Node operator includes the Beldex address which may receive Master Node rewards. This address will also be used as the public key for Master Node operations such as [swarm](../Advanced/SwarmFlagging.md) voting.

Before each node joins the Master Node network, other nodes must individually validate that the said nodes collateral outlay matches the required amount, as per the decreasing collateralisation requirement. If the node is offline for a reasonable time, its uptime proof will not be sent to the other nodes resulting in a deregister of the node. Deregistered nodes will have their collateral requirement locked for 30 days.

The staking requirement is 10,000 bdx during Master Node launch (block height 56240). The staking amount is constant at the moment. The amount may vary based on the future emmision.