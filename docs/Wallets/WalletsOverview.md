# Wallets
The Beldex wallets are a gateway into private decentralised transactions and communications. They allow you to hold private keys, secure or mine Beldex, and trade peer-to-peer. 

Beldex wallets store a collection of public and private keys which can be used to receive, view, or spend Beldex. 

The wallet uses the private keys through a daemon which synchronises with the Beldex Network to scan for incoming transactions and to send outgoing transactions.

<!-- ## Graphical User Interface Wallet (GUI)
The Gui Wallets are the easiest wallets to use. It has a graphical user friendly interface which is perfect for beginners. 

Beldex has two GUI wallets:

- The Beldex Electron wallet: [Download here](https://github.com/beldex-coin/beldex-electron-gui-wallet/releases).

- The Beldex GUI wallet: [Download here](https://github.com/beldex-coin/beldex-gui/releases)


### GUI Guides
| Guide                                                	| Description                                          	|
|------------------------------------------------------	|------------------------------------------------------	|
| [GUI Setup](../Wallets/GuiWallet/beldex-gui-guide.md)  	| How to set up the GUI wallet for the first time.     	|
| [GUI Staking](../MasterNodes/GUIStakingGuide.md) 	| How to stake to a Master Node from your GUI Wallet. 	| -->

## Command Line Interface Wallet (CLI)
The Cli Wallet is for more advanced users and offers the most tools when interacting with the Beldex Blockchain.

- [Download Beldex CLI Wallet](https://github.com/beldex-coin/beldex/releases)

- [Github Link](https://github.com/beldex-coin/beldex/)

### CLI Guides

| Guide                                                                     	| Description                                                                                                                                                                                    	|
|---------------------------------------------------------------------------	|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| [Restore CLI Wallet from Keys](../Wallets/CliWallet/WalletRestoreKeys.md) 	| How to restore your wallet with spend and view keys.                                                                                                                                           	|
| [Restore CLI Wallet from Seed](../Wallets/CliWallet/WalletRestoreSeed.md) 	| How to restore your wallet with a seed phrase (25 word mnemonic seed).                                                                                                                         	|
| [CLI Commands](../Wallets/CliWallet/WalletCommands.md)                    	| Details on different commands within the `beldex-wallet-cli`.                                                                                                                                    	|
| [2 of 2 - Multisignature Setup](../Wallets/CliWallet/2of2Multisig.md)     	| [Multisig](../Wallets/Multisignature.md) feature allows you to sign a transaction with more than one private key. Funds protected with multisig can only be spent by signing with 2-of-2 keys. 	|
| [2 of 3 - Multisignature Setup](../Wallets/CliWallet/2of3Multisig.md)     	| [Multisig](../Wallets/Multisignature.md) feature allows you to sign a transaction with more than one private key. Funds protected with multisig can only be spent by signing with 2-of-3 keys. 	|
| [M of N - Multisignature Setup](../Wallets/CliWallet/MofNMultisig.md)     	| [Multisig](../Wallets/Multisignature.md) feature allows you to sign a transaction with more than one private key. Funds protected with multisig can only be spent by signing with M-of-N keys. 	|
| [CLI Setup - Linux](../Wallets/CliWallet/beldex-wallet-cliLinuxSetup.md)        	| How to setup the `beldex-wallet-cli` for the first time on Linux.                                                                                                                               	|