# Commands:

## Displaying commands

The `beldex-wallet-cli` has multiple commands to conduct different operations on the Beldex Blockchain. By typing `help` and clicking enter after loading your wallet will bring up the commands that can be used.

## 1 Accounts

### 1.1 Creating new account

When a wallet is generated it will automatically have an account labelled `Primary account` with index `0`. If at any time you wish to create an additional account use the command:

```
account new <label text with white spaces allowed>
```

This command will create a subaddress which is labelled with a tag and index number. This subaddress will share the same seed as your Primary address. To ensure this new account is displayed you must type `exit` to save your session.

You will note that there is now an asterisk to the left of index 1. The asterisks show us the account in which the commands we run will apply to.

>Note: Restoring your wallet from your seed will not restore your accounts as the index of your subaddress data is stored on your computer within your wallet file. All the funds stored in your additional accounts will be shown in your Primary account if you need to restore your wallet from scratch.

```
[wallet bxcnR2]: account new Secondary account
[wallet bxcnR2]: Untagged accounts:
[wallet bxcnR2]: Account Balance Unlocked balance Label
[wallet bxcnR2]: 0 bxcnR2 0.000000000 0.000000000 Primary account
[wallet bxcnR2]: * 1 8Y5J5W 0.000000000 0.000000000 Secondary account
[wallet bxcnR2]: ----------------------------------------------------------------------------------
[wallet bxcnR2]: Total 0.000000000 0.000000000
```

### 1.2 Switching account

When transferring out or receiving to a specific account we need to make sure that the account we are performing the action is the one the CLI is currently connected to. An asterisk will show which account we are connected to. In the below example the asterisk is shown to the left of Secondary account so any operations will be associated with that account.

Each of the accounts connected to your Primary address will have an index associated with them. The index number will be shown to the left of the Account column. By default, index “0” is your Primary account.

```
[wallet bxcnR2]: account new Secondary account
[wallet bxcnR2]: Untagged accounts:
[wallet bxcnR2]: Account Balance Unlocked balance Label
[wallet bxcnR2]: 0 bxcnR2 0.000000000 0.000000000 Primary account
[wallet bxcnR2]: * 1 8Y5J5W 0.000000000 0.000000000 Secondary account
[wallet bxcnR2]: ----------------------------------------------------------------------------------
[wallet bxcnR2]: Total 0.000000000 0.000000000
```

To switch between the accounts you have created run the command:

```
account switch <index>
```

After running the command a similar output shown below will be on your terminal.

```
[wallet bxcnR2]: account switch 0
[wallet bxcnR2]: Currently selected account: [0] Primary account
[wallet bxcnR2]: Tag: (No tag assigned)
[wallet bxcnR2]: Balance: 0.000000000, unlocked balance: 0.000000000
```

### 1.3 Changing account labels

To change the label name connected to a specific Beldex Primary or Sub-address use the command:

```
account label <index> <label text with white spaces allowed>
``` 

Replacing `<index>` with the index number associated with the account you wish to relabel, and replacing `<label text with white spaces allowed>` with the new label you would like to name the specified account.

Below shows the current accounts and labels for a specific wallet.

```
[wallet bxmjSH]: Untagged accounts:
[wallet bxmjSH]: Account Balance Unlocked balance Label
[wallet bxmjSH]: * 0 bxmjSH 0.000000000 0.000000000 Primary account
[wallet bxmjSH]: 1 8TLgNy 0.000000000 0.000000000 Secondary
[wallet bxmjSH]: ----------------------------------------------------------------------------------
[wallet bxmjSH]: Total 0.000000000 0.000000000
```

Using the command `account label 0 My Account` we have changed the label connected to our Primary address from “Primary account” to “My Account”.

```
[wallet bxmjSH]: account label 0 My Account
[wallet bxmjSH]: Untagged accounts:
[wallet bxmjSH]: Account Balance Unlocked balance Label
[wallet bxmjSH]: * 0 bxmjSH 0.000000000 0.000000000 My Account
[wallet bxmjSH]: 1 8TLgNy 0.000000000 0.000000000 Secondary
[wallet bxmjSH]: ----------------------------------------------------------------------------------
[wallet bxmjSH]: Total 0.000000000 0.000000000
```

### 1.4 Tagging and untagging accounts:

The `beldex-wallet-cli` allows you to group accounts by tagging or untagging them.

Below shows a wallet with 4 accounts, Dog, Kid 1 and Kid 2.

```
[wallet 8VP3bv]: Untagged accounts:
[wallet 8VP3bv]: Account Balance Unlocked balance Label
[wallet 8VP3bv]: 0 bxXk6e 0.000000000 0.000000000 My Account
[wallet 8VP3bv]: 1 8RDvY6 0.000000000 0.000000000 Dog
[wallet 8VP3bv]: 2 8VJDwN 0.000000000 0.000000000 Kid 1
[wallet 8VP3bv]: * 3 8VP3bv 0.000000000 0.000000000 Kid 2
[wallet 8VP3bv]: ----------------------------------------------------------------------------------
[wallet 8VP3bv]: Total 0.000000000 0.000000000
```

We can tag a single account with the following command:
```
account tag <tag_name> <account_index>
```

```
[wallet 8VP3bv]: account tag Pets 1
[wallet 8VP3bv]: Accounts with tag: Pets
[wallet 8VP3bv]: Tag's description:
[wallet 8VP3bv]: Account Balance Unlocked balance Label
[wallet 8VP3bv]: 1 8RDvY6 0.000000000 0.000000000 Dog
[wallet 8VP3bv]: ----------------------------------------------------------------------------------
[wallet 8VP3bv]: Total 0.000000000 0.000000000
```

When needing to perform multiple tags we can do it through one command:

```
account tag <tag_name> <account_index_1> [<account_index_2> ...]
```

```
[wallet 8VP3bv]: account tag Family 2 3
[wallet 8VP3bv]: Accounts with tag: Family
[wallet 8VP3bv]: Tag's description:
[wallet 8VP3bv]: Account Balance Unlocked balance Label
[wallet 8VP3bv]: 2 8VJDwN 0.000000000 0.000000000 Kid 1
[wallet 8VP3bv]: * 3 8VP3bv 0.000000000 0.000000000 Kid 2
[wallet 8VP3bv]: ----------------------------------------------------------------------------------
[wallet 8VP3bv]: Total 0.000000000 0.000000000
```

Similarly we can untag accounts by running the following command:

```
account untag <account_index_1> [<account_index_2> ...]
```

Using the above exampled wallet we will remove our “Dog” account from “Pets”.

```
[wallet 8VP3bv]: account untag 1
[wallet 8VP3bv]: Accounts with tag: Family
[wallet 8VP3bv]: Tag's description:
[wallet 8VP3bv]: Account Balance Unlocked balance Label
[wallet 8VP3bv]: 2 8VJDwN 0.000000000 0.000000000 Kid 1
[wallet 8VP3bv]: * 3 8VP3bv 0.000000000 0.000000000 Kid 2
[wallet 8VP3bv]: ----------------------------------------------------------------------------------
[wallet 8VP3bv]: Total 0.000000000 0.000000000
[wallet 8VP3bv]:
[wallet 8VP3bv]: Untagged accounts:
[wallet 8VP3bv]: Account Balance Unlocked balance Label
[wallet 8VP3bv]: 0 bxXk6e 0.000000000 0.000000000 My Account
[wallet 8VP3bv]: 1 8RDvY6 0.000000000 0.000000000 Dog
[wallet 8VP3bv]: ----------------------------------------------------------------------------------
[wallet 8VP3bv]: Total 0.000000000 0.000000000
``` 

### 1.5 Adding Tag descriptions

If you require additional information attached to a specific tag you can add a description with the following command:

```
account tag_description <tag_name> <description>
```

For example:
  
```
[wallet 8VP3bv]: account tag_description Family This is my family.
[wallet 8VP3bv]: Accounts with tag: Family
[wallet 8VP3bv]: Tag's description: This is my family.
[wallet 8VP3bv]: Account Balance Unlocked balance Label
[wallet 8VP3bv]: 2 8VJDwN 0.000000000 0.000000000 Kid 1
[wallet 8VP3bv]: * 3 8VP3bv 0.000000000 0.000000000 Kid 2
[wallet 8VP3bv]: ----------------------------------------------------------------------------------
[wallet 8VP3bv]: Total 0.000000000 0.000000000
```

## 2 Balance

To check the balance of your wallet you can run one of two commands:

`balance` or `balance detail`

Running the command `balance` will generated a simple output showing your balance and unlocked balance of the specific account you are in. For example:

```
[wallet 86TmZX]: balance
Currently selected account: [0] Primary account
Tag: (No tag assigned)
Balance: 172286.035054991, unlocked balance: 172086.338373771
```

While running the command `balance detail` will generate a more detailed output, showing the account number, first few characters of the address, balance, unlocked balance, Outputs and the Label of the account. For example:

```
[wallet 86TmZX]: balance detail
Currently selected account: [0] Primary account
Tag: (No tag assigned)
Balance: 172286.035054991, unlocked balance: 172086.338373771
Balance per address:
Address Balance Unlocked balance Outputs Label
0 86TmZX 172286.035054991 172086.338373771  3347 Primary account
```

There are other commands that will also output the balance which have been covered by this guide, such as the `account` command.

## 3 Getting the Block Height

To show the blockchain height run the command:

```
bc_height
```

## 4 Blackballing Transactions

Blackballing transactions allows you to ignore others' outputs (containers of money) that are known to be spent in a certain transaction.

For example let’s imagine that txid: `4f4b371a0da8858bbeab8a40ff37de1f6ff33e64a616e5ced8239062570b7542` is known to be fake and if this txid is seen within a RingCT transaction the network can assume it is fake, therefore an actor has a better chance of deducing the real transaction within the RingCT.

By blackballing the above txid we remove the chance of it being used within our RingCT.

To do this we will use the following command:
```
blackball <output public key> | <filename> [add]
```

For example:

```
[wallet bxXk6e]: blackball 4f4b371a0da8858bbeab8a40ff37de1f6ff33e64a616e5ced8239062570b7542
```

To check if the txid was added to our list of txids not to use we can use the following command:

```
blackballed <output public key>
```

If the txid is on our list the following will output:

```
[wallet bxXk6e]: blackballed 4f4b371a0da8858bbeab8a40ff37de1f6ff33e64a616e5ced8239062570b7542
[wallet bxXk6e]: Blackballed: <4f4b371a0da8858bbeab8a40ff37de1f6ff33e64a616e5ced8239062570b7542>
```

Alternatively if the txid is not on our list the following will output:

```
[wallet bxXk6e]: blackballed 4f4b371a0da8858bbeab8a40ff37de1f6ff33e64a616e5ced8239062570b7542
[wallet bxXk6e]: not blackballed: <4f4b371a0da8858bbeab8a40ff37de1f6ff33e64a616e5ced8239062570b7542>
```

To unblackball a txid use the following command:

```
unblackball <output public key>
```

For example:

```
[wallet bxXk6e]: unblackball 4f4b371a0da8858bbeab8a40ff37de1f6ff33e64a616e5ced8239062570b7542
```

## 5 Reserve Proof

Reserve Proofs are used to generate a signature proving that you own an amount of Beldex, with the option to sign the reserve proof with a key.

For example let’s imagine you see a car for sale but they will accept Beldex as payment, however they have advised in their online listing that they are only interested in serious buyers and require you to prove you have the Beldex within your initial contact. Luckily we can use the Reserve Proof commands for this proof.

### 5.1 Generate Reserve Proof

To begin we will need to run the `get_reserve_proof` command to generate our proof.

```
get_reserve_proof (all|<amount>) [<message>]
```

If the individual you are sending this proof to requires you to prove you have 1000 Beldex you will need to replace the section `(all|<amount>)` with a 1000, otherwise replace it with the amount you need to prove you have reserved. If you want to put an extra layer of encryption over the file replace `[<message>]` with a password.

Your command will similar to the below command:

```
get_reserve_proof 1000 Car
```

The Cli will request your wallet password and once your password is entered it will tell you it generated a signature file.

```
[wallet 86TmZX]: get_reserve_proof 1000 Car
Wallet password:
signature file saved to: beldex_reserve_proof
```

This signature file `beldex_reserve_proof` will be saved in your Beldex folder, where your daemon and wallet keys are. Keep in mind every time you run the `get_reserve_proof` command it will overwrite your `beldex_reserve_proof` file.

You will want to send this file to the person who requires the proof. You can upload the `beldex_reserve_proof` file through [https://transfer.sh/](https://transfer.sh/) by running the command within the folder of your signature file:

```
curl --upload-file ./beldex_reserve_proof https://transfer.sh/beldex_reserve_proof`
```

The terminal will then print out a link to your signature file which you can then provide to the individual performing the check.

```
https://transfer.sh/QhoC7/beldex_reserve_proof
```

Make sure you provide the following to the individual who will be checking your reserve proof:

-   The beldex_reserve_proof file through the transfer.sh link.

-   The beldex address you are proving has Beldex in it.
    
-   The `<message>` if you encrypted the file.

### 5.2 Checking Reserve Proof

To check a reserve proof we need to first have the `beldex_reserve_proof` file in our Beldex folder.

If you do not have the `beldex_reserve_proof` file in your beldex folder request the individual sending the file to you to use [https://transfer.sh/](https://transfer.sh/), once they send you the link to their `beldex_reserve_proof` you can use the following command to download it.

```
curl <link> -o beldex_reserve_proof
```

Replacing `<link>` with the link to download the `beldex_reserve_proof`.

Now that the `beldex_reserve_proof` is in our folder we can run the following command:

```
check_reserve_proof <address> <signature_file> [<message>]
```

Where `<address>` is the address of the wallet where the command get_reserve_proof was ran. `<signiture_file>` is the file that was received from the individual sending you the reserve proof, normally generated as `beldex_reserve_proof` and `<message>` is the key set by the individual who sent you the reserve proof.

Therefor for the previous example where we created a reserve proof for 1000 beldex and signed with “car”, we would run the command:
  
```
check_reserve_proof bxTmZX8EzZVjS9zNg7zAsrEQFDgcVC2qV2ZMyoWsbyK4SNB2SwMHZtMhPSsFyTmRBQUaGVF5k3qy5CMFM6Lvj7gi3AeszDag7 beldex_reserve_proof Car
```

If all goes well, the terminal will output the following:

```
Good signature -- total: 1014.862440831, spent: 0.000000000, unspent: 1014.862440831
```

You may note that it shows a reserve proof which is greater than 1000, this is because the command is adding up all the transactions into the address specified until it is greater than the reserve proof set.

## 6 Spend Proof

Spend Proofs are used to generate a signature proving that you generated a TXID, with the option to sign the spend proof with a key.

For example let’s imagine you have bought a car from a dealership with beldex and have sent 1000 BDX to the seller. Unfortunately the dealer does not know which transaction is yours as he has received 5 transactions of 1000 BDX in the same block for 5 different cars. He knows the txid’s but wants you to prove that you have generate one of the txid’s in his list. Luckily we can prove we generated the txid by using the `get_spend_proof` command.

### 6.1 Generate Spend Proof

To begin we will first need to find the txid associated with our transaction. To do this run the following command in our wallet:

```
show_transfers
```

The terminal will output a list of transactions in and out of your address. You should have a transaction in your list with the amount you spent to the dealership. Copy the txid(by highlighting) associated with this transaction and save it in a notepad for later.

We can now run the `get_spend_proof` command to generate our proof.

```
get_spend_proof <txid> [<message>]
```

Replacing `<txid>` with the txid of our transfer out and replacing `<message>` if we want to add a password to the proof. If all went well the terminal will output the following text:

```
signature file saved to: beldex_spend_proof
```

This signature file `beldex_spend_proof` will be saved in your Beldex folder, where your daemon and wallet keys are. Keep in mind every time you run the `get_spend_proof` command it will overwrite your `beldex_spend_proof file`.

You will want to send this file to the person who requires the proof. You can upload the beldex_spend_proof file through [https://transfer.sh/](https://transfer.sh/) by running the command within the folder of your signature file:

```
curl --upload-file ./beldex_spend_proof https://transfer.sh/beldex_spend_proof
```

The terminal will then print out a link to your signature file which you can then provide to the individual performing the check. For example:

```
https://transfer.sh/QhoC7/beldex_spend_proof
```

Make sure you provide the following to the individual who will be checking your reserve proof:

-   The `beldex_spend_proof` file through the transfer.sh link.

-   The beldex transaction txid associated with the transaction you are proving you generated.
    
-   The `<message>` if you encrypted the file.

### 6.2 Checking Spend Proof

To check a spend proof we need to first have the `beldex_spend_proof` file in our Beldex folder and the txid associated with the transaction being proved.

If you do not have the `beldex_spend_proof` file in your beldex folder request the individual sending the file to you to use [https://transfer.sh/](https://transfer.sh/), once they send you the link to their `beldex_spend_proof` you can use the following command to download it.

```
curl <link> -o beldex_spend_proof
```

Replacing `<link>` with the link to download the `beldex_spend_proof`.

Now that the `beldex_spend_proof` is in our folder we can run the following command:

```
check_spend_proof <txid> <signature_file> [<message>]
```

Where `<txid>` is the txid associated with the transaction that is being proved. `<signiture_file>` is the file that was received from the individual sending you the spend proof, normally generated as `beldex_spend_proof` and `<message>` is the key set by the individual who sent you the spend proof.

An example would look like the following command

```
check_spend_proof 20eb3b5545d6587e5a379feb2fc69b43d4f8b6b825bb7eff78e263d4e7e8eaa9 beldex_spend_proof car
```

If all goes well, the terminal will output the following:

```
Good signature
```

If you receive a `Good signature` message that should be a good proof that the txid you are checking was generated from the sender. Keep in mind however that this can potentially not always be the case, considering someone could get access to someone else's computer thus having access to this file.

## 7 TX Proof

TX Proofs are used to generate a signature file proving that you generated a TXID, with the option to sign the spend proof with a key. TX proofs work similar to Reserve Proof’s and Spend Proofs however they show more detailed information.

For example let’s imagine you have bought a car from a dealership with beldex and have sent 1000 BDX to the seller. Unfortunately the dealer does not know which transaction is yours as he has received 5 transactions of 1000 BDX in the same block for 5 different cars. He knows the txid’s but wants you to prove that you have generate one of the txid’s in his list. Luckily we can prove we generated the txid by using the get_tx_proof command.

### 7.1 Generate Spend Proof

To begin we will first need to find the txid associated with our transaction. To do this run the following command in our wallet:

```
show_transfers
```

The terminal will output a list of transactions in and out of your address. You should have a transaction in your list with the amount you spent to the dealership. Copy the txid(by highlighting) associated with this transaction and save it in a notepad for later.

We can now run the `get_tx_proof` command to generate our proof.

```
get_tx_proof <txid> <address> [<message>]
```

Replacing `<txid>` with the txid of our transfer out, `<address>` with the receiver's address, and replacing `<message>` if we want to add a password to the proof. If all went well the terminal will output the following text:

```
signature file saved to: beldex_tx_proof
```

This signature file `beldex_tx_proof` will be saved in your Beldex folder, where your daemon and wallet keys are. Keep in mind every time you run the `get_tx_proof` command it will overwrite your `beldex_tx_proof` file.

You will want to send this file to the person who requires the proof. You can upload the `beldex_tx_proof` file through [https://transfer.sh/](https://transfer.sh/) by running the command within the folder of your signature file:

```
curl --upload-file ./beldex_tx_proof https://transfer.sh/beldex_tx_proof
```

The terminal will then print out a link to your signature file which you can then provide to the individual performing the check. For example:

```
https://transfer.sh/QhoC7/beldex_tx_proof
```

Make sure you provide the following to the individual who will be checking your reserve proof:

-   The `beldex_tx_proof` file through the transfer.sh link.

-   The beldex transaction txid associated with the transaction you are proving you generated.
    
-   The receivers beldex address.
    
-   The `<message>` if you encrypted the file.

### 7.2 Checking tx Proof

To check a tx proof we need to first have the `beldex_tx_proof` file in our Beldex folder, the receiver's address and the txid associated with the transaction being proved.

If you do not have the `beldex_tx_proof` file in your beldex folder request the individual sending the file to you to use [https://transfer.sh/](https://transfer.sh/), once they send you the link to their `beldex_tx_proof` you can use the following command to download it.

```
curl <link> -o beldex_tx_proof
```

Replacing `<link>` with the link to download the `beldex_tx_proof`.

Now that the `beldex_tx_proof` is in our folder we can run the following command:

```
check_tx_proof <txid> <address> <signature_file> [<message>]
```

Where `<txid>` is the txid associated with the transaction that is being proved, `<address>` is the receiver’s address and `<signiture_file>` is the file that was received from the individual sending you the tx proof, normally generated as `beldex_tx_proof` and `<message>` is the key set by the individual who sent you the tx proof.

An example would look like the following command:
```
check_tx_proof 3f8c62b4d83100ff4f89b44a96350e65aeaa83a9b4273c31f94b9aa12e713044 8RrEpWMLd3rRuirYqsjg1iaNsukAAojWjFDhJ2kK2o4uM6tkcjMerA4SZNat6QHEYe1SoGCFQddVPgRqmkA8kARX1ffU1Wcjc beldex_tx_proof
```

If all goes well, the terminal will output the following:

```
Good signature
TRrEpWMLd3rRuirYqsjg1iaNsukAAojWjFDhJ2kK2o4uM6tkcjMerA4SZNat6QHEYe1SoGCFQddVPgRqmkA8kARX1ffU1Wcjc received 40000.000000 in txid <3f8c62b4d83100ff4f89b44a96350e65aeaa83a9b4273c31f94b9aa12e713044>
This transaction has 1 confirmations
```

If you receive a `Good signature` message that should be a good proof that the txid you are checking was generated from the sender. Keep in mind however that this can potentially not always be the case, considering someone could get access to someone else's computer thus having access to this file.

## 8 TX key

A TX key is a private key associated with a TXid. Only the wallet that has sent the transaction can generate a TX key from the TXID that both parties can see. A TX key can be used to validate a transaction on a case by case basis. In essence, you can provide the tx key, txid and the receiver address to someone to prove you had generate that transaction.

### 8.1 View TX key

To view the TX key of a specific transaction you have generate you will need to run the command:

```
get_tx_key <txid>
```

Where `<txid>` is the transaction id associated with the transfer out you are proving is yours.

The terminal will prompt the user for the wallets password and then print out the tx key, which will look similar to:

```
[wallet 86TmZX]: get_tx_key d5fb415aad43f4e45bc72566d5ad4c8f12629db1f924d953efc2521c137a987f
Wallet password:
Tx key: 5dfc4d677e2707317f306219b6aa445feaab4c652927237c012f7e72cb41bf0e
```

Provide the `<tx key>` with the `<txid>` and `<receiving address>` to the individual who will run the validation, thus this will prove you generated the transaction.

### 8.2 Validate transaction with TX key

Once we have a `<tx key>`, `<txid>` and `<receiving address>` from a specific transaction we can use the following command to prove they are all associated:

```
check_tx_key <txid> <txkey> <address>
```

For the previous example we would run the following command from any beldex wallet:

```
check_tx_key d5fb415aad43f4e45bc72566d5ad4c8f12629db1f924d953efc2521c137a987f 5dfc4d677e2707317f306219b6aa445feaab4c652927237c012f7e72cb41bf0e 86TZ2VaG1p9PQkDgdVCYwnjoxYSU7ErXX56etGsqHLugAGqynFwBvP4dnN7wvYCcJfMa9LPgtYu8UEUqyc4xsxmx2ZTyMp4U3
```

The terminal will show text of how much Beldex the address received. It will also show how many confirmations the transaction has received from the blockchain. For example:

```
[wallet 86TZ2V]: check_tx_key d5fb415aad43f4e45bc72566d5ad4c8f12629db1f924d953efc2521c137a987f 5dfc4d677e2707317f306219b6aa445feaab4c652927237c012f7e72cb41bf0e 86TZ2VaG1p9PQkDgdVCYwnjoxYSU7ErXX56etGsqHLugAGqynFwBvP4dnN7wvYCcJfMa9LPgtYu8UEUqyc4xsxmx2ZTyMp4U3  
86TZ2VaG1p9PQkDgdVCYwnjoxYSU7ErXX56etGsqHLugAGqynFwBvP4dnN7wvYCcJfMa9LPgtYu8UEUqyc4xsxmx2ZTyMp4U3 received 10000.000000000 in txid <d5fb415aad43f4e45bc72566d5ad4c8f12629db1f924d953efc2521c137a987f>
This transaction has 10 confirmations
```

## 9 Tx Notes

The `beldex-wallet-cli` allows you to add notes to specific txid’s, however this note does not get stored on the blockchain, rather it is stored on client side, on the device that generates the `tx_note`.

### 9.1 Set tx note

To set a tx note we will need a the `<txid>` and the `<message>` you want to add to the txid. For instance, if you want to add a note to a txid that is connected to your wallet run the following command to show your transactions in/out with their `<txid>`’s:

```
show_transfers
```

To set the note to the `<txid>` run the following command:

```
set_tx_note <txid> [free text note]
```

Where `<txid>` is the transaction id associated to the transaction you are adding the `[free text note]` too. Your command will look similar to the following example:

```
[wallet 86TmZX]: set_tx_note d5fb415aad43f4e45bc72566d5ad4c8f12629db1f924d953efc2521c137a987f This is a tx note example.
```

### 9.2 View tx note

To view a note connected to a txid run the following command:

```
get_tx_note <txid>
```

Where `<txid>` is the transaction id that has the note connected to it. For example, if we run the command on the previous `<txid>` mentioned, the terminal will display the following text:

```
[wallet 86TmZX]: get_tx_note d5fb415aad43f4e45bc72566d5ad4c8f12629db1f924d953efc2521c137a987f
note found: This is a tx note example.
```

You can also view a tx note by running the `show_transfers` command, each transaction that has a note connected to it will display the text to the right of each transfer.

## 10 Changing wallet password

Changing the wallet password is only client side(locally), and if the password is forgotten the wallet can always be restored with the mnemonic seed. If you know the password to the wallet and want to change it you can run the following command:

```
password
```

Once the command has been run the terminal will prompt you for the current password and the new password twice. If entered correctly the terminal will go back to receiving inputs, otherwise the terminal will output an error such as `Passwords do not match! Please try again` or `Error: invalid password`.

## 11 Encrypting seed phrase

Your seed passphrase is a 25 word phrase which is used to recover access to your wallet on a client or gui and is. The command `encrypted_seed` allows your to add an additional password, or encryption layer, to your 25 word mnemonic seed. Encrypting your seed will stop others from recovering access to your wallet if they somehow gain access to your 25 word mnemonic seed as they will not have the passphrase that decrypts them. This means, your passphrase should not be written or saved in the same location as your encrypted 25 word mnemonic seed phrase.

To encrypt your seed run the following command:

```
encrypted_seed
```

Initially the cli wallet will prompt you to enter your wallet password. Next it will request for your seed encryption passphrase, enter in your desired password/passphrase once, click enter, then type the passphrase in again.  

The wallet will output your mnemonic seed which is a 25 word passphrase. It is generally best practice to write these 25 words down and store them somewhere safe and securely, write your passphrase down(which is the phrase you used to encrypt the 25 words) and store this somewhere else. Storing the 25 words with the passphrase in a file on your computer that is not encrypted is giving others easier access to your mnemonic seed.