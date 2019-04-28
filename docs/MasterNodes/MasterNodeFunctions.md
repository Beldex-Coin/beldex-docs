# Master Node Functions

## Remote Nodes

On any given cryptocurrency network, storing a full copy of the blockchain is not possible or practical for many users.   In Bitcoin and Ethereum, users can choose to connect to a public full node that holds a copy of the blockchain and can query and submit transactions to the network. This works because Bitcoin and Ethereum full nodes can efficiently search the blockchain for transactions that have the users public key as the target.

Due to the construction of CryptoNote currencies, public full nodes (called remote nodes) are put under much more stress.  When a user connects to a remote node, they must temporarily download every block (upon wallet creation or since last checked block) to their local machine and check each transaction for a public transaction key which can be generated from the users private view key. This process can cause a significant performance impact on remote nodes. Considering that there is no reward for this service, it can dissuade users from operating syncing services for light clients. CryptoNote mobile wallets are often unreliable and sometimes have to switch between remote nodes multiple times before establishing a reliable connection to either scan the blockchain or to submit a transaction.

Additionally, malicious remote node operators running one of the few popular nodes can record the IP address of users as they broadcast specific transactions.  Although no information about the actual transaction is revealed by this attack, specific IP addresses can be linked with transactions which can then be used to establish a link to a real-world identity, compromising privacy.

Beldex circumvents these issues by requiring each [Master Node](../MasterNodes/MNOverview.md) to act as a remote node that can be used by general users. Master Nodes naturally lend themselves to this work as they already hold a full copy of the  blockchain and form a widely distributed network of high bandwidth nodes. By using Master Nodes as remote nodes, there is an inherent financial limitation as to how much of the remote node network any given party can own, and therefore, how much data a malicious node operator can collect.

