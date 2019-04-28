# Swarm Flagging

>> Define Swarm Flagging

When nodes operate in a trustless environment without a centralised leader enforcing over arching rules, maintaining proper node behaviour on the network becomes difficult. Although [Master Nodes](../MasterNodes/MNOverview.md) in Beldex must hold the correct [collateral requirement](../MasterNodes/StakingRequirement.md), they may choose to not [route traffic](../Beldexnet/LLARP.md) or [store data](../BeldexServices/Messenger.md) in their memory pools.  Because this option is financially beneficial (using less bandwidth/CPU cycles/storage), a system of distributed flagging must be proposed to remove underperforming nodes.

For Beldex, such distributed flagging faces major implementation issues. Fundamentally, every [Master Nodes](../MasterNodes/MNOverview.md) is financially incentivised to flag every other Master Node as a bad actor. This is because when a Master Node is flagged it will face removal from the staking pool and thereby increase the flaggers chance at winning a reward. One potential method of  distributed flagging is one in which evidence is provided when a flagging event occurs, however, this solution falls prey to nodes fabricating evidence in their favour.  Conversely, flagging without restrictions allows either single nodes or groups of collaborating nodes to intentionally flag honest nodes in order to improve their chances of winning [block  rewards](../Advanced/Cryptoeconomics.md). To circumvent these issues, Beldex proposes swarm flagging.

Swarm flagging works by using existing swarms to choose members that will participate in each testing round. Each Master Node holds a copy of the blockchain, and each block created by a miner will deterministically select a number of test swarms. Every block, 1% of the networks swarms are selected for participation in a testing swarm. To calculate participating swarms, the hash of the five previous blocks is used to seed a Mersenne Twister function which then selects swarms by order of their position in the deterministic list.

![Testing Swarm](../assets/Swarm.PNG)

When a swarm has been selected to participate, each node in that swarm is expected to conduct a number of tests on every other node in the swarm. These are not active tests; rather each node stores historical information about its interactions with every other nodenwithin its swarm. Information about bandwidth, [message storage](../BeldexServices/Messenger.md), blockchain requests, and [exit node](/MasterNodes/ServiceNodeFunctions/#exit-nodes) functionality are collected and retained over time. New swarm entrants that have yet to gather this information can query [Master Nodes](../MasterNodes/MNOverview.md) outside of their immediate swarm so as to gather data on each of the Master Nodes they test.

Each [Master Nodes](../MasterNodes/MNOverview.md) decides how to vote on each of the other swarm members. Once it has made its decision based on the aforementioned tests, it collects and broadcasts its votes to the swarm. Each node in the swarm can now check the votes for all members. If any single node in the swarm has over 50% of the nodes voting against  it, any swarm member has the required information to construct a deregistration transaction. Once this transaction is validated and included in a block, all Master Nodes update their DHT, purging any nodes that were voted off.

![Dishonest Node](../assets/Swarm2.PNG)

## Testing Suite

In order to allow the network to self-enforce performance standards, [Master Nodes](../MasterNodes/MNOverview.md) must be equipped with the required tools so as to test other Master Nodes. These tests should cover the scope of all functionality provided by Master Nodes to prevent [lazy masternode attacks](https://www.reddit.com/r/dashpay/comments/5t6kvc/lazy_masternodes_do_you_actually_have_to_do_any/). In this initial design, four fundamental tests are proposed. Further tests may be added to the test suite as the function of Services Nodes expands.

When an operator first runs the [Master Nodes](../MasterNodes/MNOverview.md) software, an empty file with a predetermined size is allocated on disk to ensure that space is present for tasks that require storage. Next, a simple bandwidth test is conducted between the Master Node and a geographically distributed set of testing servers run by the [Beldex Foundation](../Governance/TheBeldexFoundation.md). These checks are optional, and Master Nodes are allowed to skip, ignore or fail them, and join the pool of untrusted Master Nodes.  However, running and passing these tests provides a good indicator to any would-be Master Node operator as to whether they should risk [locking collateral](../MasterNodes/StakingRequirement.md) in a node that may not meet minimum requirements. Once a Master Node joins the untrusted Master Node pool, their collateral is locked and they are tested by the next chosen swarm. Swarm tests are enforced via consensus and new entrants to the Master Node network cannot evade these tests. If a node passes all swarm tests, they are awarded the trusted node flag and can begin routing packets. Failing this, they are removed from the network and their collateral remains locked for 30 days.

### Bandwidth Test

The bandwidth test forms the backbone of the Beldex network test suite. If a node passes this test then it is assumed to be honestly routing packets above the minimum threshold.

Each time a node interacts with another Master Node, it will make and retain a record of the incoming bandwidth provided.  Over time, nodes will be included in thousands of paths and route millions of [messages](../BeldexServices/Messenger.md). These interactions will form the basis of each nodes bandwidth tables. From this table, a node can respond to bandwidth tests about Master Nodes inside its swarm.

All nodes are also expected to respond to queries of their own bandwidth tables from other nodes. This means that even  nodes who have recently joined the network can query the wider network for information about any specific node in their swarm.

### Message Storage Test

Message storage is essential for offline messaging functionality for users of [Beldex Messenger](../BeldexServices/Messenger.md). [Master Nodes](../MasterNodes/MNOverview.md) must be tested for their ability to cache messages and serve them to users over the course of the message’s Time-to-live (TTL).

Users sending offline messages randomly select a Master Node within the destination users swarm. This node must distribute a copy of the message amongst the rest of the swarm. Depending on the proof-of-work attached to the header of the message, Master Nodes that receive a copy will store the data for the TTL. As the TTL on the original message reaches finality, the distributing node sends a nonce to all other members of the swarm. The swarm uses the nonce adding it to the message then  hashing  the result  and  then finally  sending it back to the distributing node. This test ensures that Master Nodes hold messages until TTL finality, and face eviction if they are unable to produce the correct message digest. As the sampling of the distributing node is random, over time each Master Node will be able to collect performance data on their swarm peers.

### Blockchain Storage Test

[Master Nodes](../MasterNodes/MNOverview.md) are expected to hold a full copy of the Beldex blockchain. By holding a full copy of the blockchain, Master Nodes can perform a number of tasks that are essential to users of the network including acting as a [remote node](/MasterNodes/ServiceNodeFunctions/#remote-nodes), validating transactions, and locking transactions in [Blink](../BeldexServices/Blink.md).

As honest nodes also hold a copy of the blockchain, a dishonest node could avoid holding a full copy by simply requesting  blocks from an honest node when tested. To avoid this outcome, the blockchain storage test is designed so that honest nodes that hold a copy of the blockchain can pass this test, while dishonest nodes cannot.

To achieve this, the testing node requests each tested node to make a selection of ***K*** random transactions within the history of the blockchain which are then concatenated and hashed. This hash is then returned to the testing node. By measuring the latency of this request, the testing node can compare the latency with the expected return time ***T***. The exact value for ***T*** will be set to accurately differentiate expected latency between loading from disk and downloading blocks from the network. For any attacker, it should be infeasible to download and hash ***K*** blocks within ***T***, and thus piggybacking attacks become difficult. 

### Exit Node Test

[Master Nodes](../MasterNodes/MNOverview.md) that opt to act as [exit nodes](/MasterNodes/ServiceNodeFunctions/#exit-nodes) receive additional rewards, and so functional tests are required to ensure this extra reward is not abused.

For functional exit testing to occur, a Master Node must be able to emulate the natural search behaviour of a human. If a Master Node can detect that it is being tested, it can respond only to tests and discard legitimate user requests. Emulating natural page request behaviour is difficult, however, exit tests can be designed in such a way so as to make the overhead of sorting between legitimate requests and tests sufficiently difficult so that the difference in bandwidth cost between running a legitimate node and a malicious node is negligible.

Master Nodes use a list of search engines, held locally, combined with a dictionary so as to construct pseudorandom natural search terms. The search terms are then fed into the search engines and web pages are randomly chosen from the results. The Service node can now build a path with random nodes acting as relays and the node being tested as the exit node. From this exit, the Master Node requests the webpage result generated from its pseudorandom search. If the result returned by the exit node matches the result as generated by the Master Node, then the exit node is deemed to have passed the test.