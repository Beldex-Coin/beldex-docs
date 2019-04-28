# GUI-Pool-Staking-Guide

This document will tell you exactly how to stake via the Beldex GUI wallet.

The latest version of the wallet can be downloaded [here](https://github.com/beldex-coin/beldex-gui/releases).

Please keep in mind, one can **only stake via an open pool with the GUI wallet**. If you would like to stake your own node or a create pool, please view the full guide on service nodes [here](../MNFullGuide).

 Also, this best done with a primary wallet address that is **not receiving mining transactions**. A separate primary wallet for Staking is recommended.

1) Open the wallet, enter your password, and let it fully sync to the latest blockheight.
![Open-Wallet-Fully-sync](../assets/images/GUI_Stake_Step1.PNG)

2) Click on the **advanced** and then on the **service node** tab.

![Click-service-node-tab](../assets/images/GUI_Stake_Step2.PNG)

3) On this step you will need to enter the service node public key obtained from the node operator or [BeldexBlocks](http://explorer.beldexcoin.com/service_nodes), your primary wallet address to receive awards, and the amount of Beldex you are contributing to the node.

![Beldex-blocks-SN-List](../assets/images/Beldex_blocks_SN_list.PNG)

4) Once that is filled out, simply hit the `stake` button.

![Staking-step](../assets/images/GUI_Stake_Step3.PNG)

>(Please note, if you receive an error at this step, you will likely need to use the [Beldex CLI](https://github.com/beldex-coin/beldex/releases) to run `sweep_all(YOUR ADDRESS)` to fix this or simply use a separate GUI wallet primary address)

5) Congratulations, you are now staking!

