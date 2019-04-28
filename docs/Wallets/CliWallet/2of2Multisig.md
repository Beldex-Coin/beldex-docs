# Beldex 2/2 Multisig

First, the wallet to be converted to multisig must be empty. It is best to use a brand-new wallet for the purpose, although not required. It is strongly advised to make a copy of the wallet files first, just in case something goes wrong.

## Overview

In short, the process is:

**Set-up**

1.  Both parties prepare `beldex-wallet-cli` files
    
2.  Both parties command `prepare_multisig` and send data to each other
    
3.  Both parties command `make_multisig`

**Receiving**

1.  All parties can type address to see the created multisig wallet address. The address will, of course, be the same for all parties since they're all watching the same wallet.

**Preparation for Sending**

1.  To prepare for sending both parties command `export_multisig_info <filename>` and send the file to the other party
    
2.  To complete preparation, all parties command `import_multisig_info <filename1> <filename2>` and import files from other parties

**Sending**

1.  To send, any party can use the usual transfer command, but the result will be a file named `multisig_beldex_tx` which must be sent to any 1 other signer
    
2.  The other party commands `sign_multisig multisig_beldex_tx` and the file is updated with the signature.
    
3.  The completely signed file is pushed to the network with use of `submit_multisig multisig_beldex_tx`

Below is a step-by-step walkthrough.

## Set-up

### Step 1 Initiate Creation of Multisig Wallet and Exchange Data

Requirements:

-   2 empty `beldex-wallet-cli` wallets
    
-   Both wallets connected to `beldexd`
    
-   Private communication channel

**Person A** must run the command in their `beldex-wallet-cli`:

```
prepare_multisig
```

**Person A** will receive the output:

```
MultisigV1cYuTGuf8FSiCYnMtLU4sZzeKZgeMy51qf4CcG2EQ2BPqKTii6YanpNLJDTM9rVRNfBPNFnJHoCWwGT9d8kB2UEDNHDxjgaAZX6DAWtj9VBFq9Q5qHjduozaYzgYpbVfHKHUQR2UrJjyX7tCSyd8gFEHUSocDRejRZBrFrKNifri5ozpN

Send this multisig info to all other participants, then use make_multisig <threshold> <info1> [<info2>...] with others' multisig info

This includes the PRIVATE view key, so needs to be disclosed only to that multisig wallet's participants
```

Copy the entire line `Multisig...5ozpN` and be sure to capture the whole thing when copying.

Send this line to person B through a private communication channel.

**Person B** does the same and sends his output to person A.

**Person B** must run the command in their `beldex-wallet-cli`:

```
prepare_multisig
```

**Person B** will receive the output:

```
MultisigV1BU9w9mysQMhNTYcNFQgD82VQiKFGpkwy8Jmu13iWWBmoeRbqyuYmEh22bJRk945ntuDeazTsYwUCYZcCL1cxuf4xDzwUJCLkiYhPCvF7gv3xrCGkAiozirNUG6CxRa53mHqp4Cvdj3yxcQcYbXNYC1ecybbQMW1gs5BBQiruVGeJi4FS

Send this multisig info to all other participants, then use make_multisig <threshold> <info1> [<info2>...] with others' multisig info

This includes the PRIVATE view key, so needs to be disclosed only to that multisig wallet's participants
```

**Person B** will copy the `Multisig…...eJi4FS` and send it to person A through a private communication channel.

### Step 2 Create Multisig Wallets

**Both person A** and **person B** now have the `Multisig...arg` text from the other one. With that, each of them can create their part of the multisig wallet. Before you proceed, note that the wallet will lose access to the underlying account when converted to multisig. This is not really a problem, since we started with an empty one, and if all goes ok with this step, you won't ever need it unless you want to go through the process again for whatever reason (like HDD died, but you have the seed mnemonic of the underlying account and want to reconstruct the multisig wallet).

**Person A** will use the output Person B sent and will run the command:

````
make_multisig 2 MultisigV1BU9w9mysQMhNTYcNFQgD82VQiKFGpkwy8Jmu13iWWBmoeRbqyuYmEh22bJRk945ntuDeazTsYwUCYZcCL1cxuf4xDzwUJCLkiYhPCvF7gv3xrCGkAiozirNUG6CxRa53mHqp4Cvdj3yxcQcYbXNYC1ecybbQMW1gs5BBQiruVGeJi4FS
````

The wallet will output something similar to:

```
2/2 multisig address: 86ScXhWpAG2aUHmFemwvn4HddHA5GQ4u6MvYsW2hVteJSwLJXCEhk2aVp4XzyqGmvyUqc3w8fwWwg6szGEytUSx51C6WQ3er8
```

**Person B** will use the output Person A sent and run the command:

```
make_multisig 2 MultisigV1cYuTGuf8FSiCYnMtLU4sZzeKZgeMy51qf4CcG2EQ2BPqKTii6YanpNLJDTM9rVRNfBPNFnJHoCWwGT9d8kB2UEDNHDxjgaAZX6DAWtj9VBFq9Q5qHjduozaYzgYpbVfHKHUQR2UrJjyX7tCSyd8gFEHUSocDRejRZBrFrKNifri5ozpN
```

The wallet will output something similar to:

```
2/2 multisig address: 86ScXhWpAG2aUHmFemwvn4HddHA5GQ4u6MvYsW2hVteJSwLJXCEhk2aVp4XzyqGmvyUqc3w8fwWwg6szGEytUSx51C6WQ3er8
```

Now each person involved should exchange addresses and compare, they must be the same.

## Receiving

### Step 1 Fund The Multisig Account

This is simple. Just send to the shared address. You can send multiple times, this is the same as a normal wallet. You can use payment ID’s as well, or generate an integrated address to receive funds.

Best part, whomever is sending the funds won't be able to tell that the address belongs to a multisig wallet since it looks like any other.

### Step 2 Check Multisig Account Balance

Just open the wallet and command refresh. Once completed, both persons can verify that the funds arrived.

**Person A** commands:

```
show_transfers
```

**Person A** outputs:

```
56156 in 07:50:35 PM 0.100000000000 88ba687dc79a0b39e6de6d0763eda8363d33d9f58ec9a096171bd9a7f1dae873 0000000000000000 -  
56156 in 08:00:18 PM 0.100000000000 d6ac845b9400759525519cdc5d514eb8f5b1d265b24d1c016e75b20ed3b4b7da 0000000000000000 -
```

**Person B** can do the same:

```
show_tranfers
```

**Person B** has the same outputs:

```
56156 in 07:50:35 PM 0.100000000000 88ba687dc79a0b39e6de6d0763eda8363d33d9f58ec9a096171bd9a7f1dae873 0000000000000000 -  
56156 in 08:00:18 PM 0.100000000000 d6ac845b9400759525519cdc5d514eb8f5b1d265b24d1c016e75b20ed3b4b7da 0000000000000000 -
```

## Spending

### Step 1 Synchronizing Key Images

#### 1.1 Exporting Multisig Info

Without this step, it will not be possible to create a spending transaction.

**Both persons** need to run the following command to sync their key images:

```
export_multisig_info <filename>
```

Where `<filename>` can be any filename.

**Person A** will run the command:

```
export_multisig_info mi1
```

**Person A** will receive the output:

```
Multisig info exported to mi1
```

The file `mi1` will be located in the shell working folder*

**Person A** sends that file to Person B. They can send the file in many ways, preferably through by handing a usb drive with the file on it, however If you would like to send the file through terminal use [https://transfer.sh/](https://transfer.sh/), an optional step has been added if you choose to use this method.

**Person B** does the same, but changing the filename and runs the command:

```
export_multisig_info mi2
```

**Person B** will receive the output:

```
Multisig info exported to mi2
```

The file `mi2` will be located in the shell working folder*

**Person B** sends that file to person A.

Now, they must both import each other's file.

#### Optional: Step 1.2 Sending Multisig Info File with terminal - transfer.sh

It is optional to use the terminal to send each person the multisig info files.

##### Uploading Multisig Info file

**Person A** will open up a new terminal and change to the directory “mi1” has been saved.*

**Person A** will run the following command:

```
curl --upload-file ./mi1 https://transfer.sh/mi1
```

**Person A** will receive the link to the file as an output, looking similar to:

```
https://transfer.sh/Ehl5q/mi1
```

**Person A** will need to send this link to Person B.

**Person B** will run a similar command:

```
curl --upload-file ./mi1 https://transfer.sh/mi2
```

*Person B* will receive the link to the file as an output, looking similar to:

```
https://transfer.sh/Iedv9/mi2
```
*Person B* will need to send this link to Person A.

###### Downloading Multisig Info file

**Person A** should change to the directory of their `beldex-wallet-cli` and use Person B’s download link to run the command:

```
curl <Person B link> -o <filename>
```

Replacing `<Person B link>` with the link Person B shared with Person A and `<filename>` with the filename of the Multisig info file that Person A generated, for example **Person A** will run the command:

```
curl https://transfer.sh/Iedv9/mi2 -o mi2
```

Likewise, **Person B** should do the same, changing directories to their `beldex-wallet-cli` and downloading with Person A’s download link, and filename.

```
curl https://transfer.sh/Ehl5q/mi1 -o mi1
```

#### Step 1.3 Importing Multisig Info

**Person A** will run the command:

```
import_multisig_info mi2
```

Depending on the transactions made in to the multsig wallet the output will look similar to:

```
2 outputs found in mi2  
Height 56156, transaction <88ba687dc79a0b39e6de6d0763eda8363d33d9f58ec9a096171bd9a7f1dae873>, received 0.100000000000  
Height 56156, transaction <d6ac845b9400759525519cdc5d514eb8f5b1d265b24d1c016e75b20ed3b4b7da>, received 0.100000000000
```

**Person B** will run a similar command:

```
import_multisig_info mi1
```

and the output will look like:

```
2 outputs found in mi1  
Height 56156, transaction <88ba687dc79a0b39e6de6d0763eda8363d33d9f58ec9a096171bd9a7f1dae873>, received 0.100000000000  
Height 56156, transaction <d6ac845b9400759525519cdc5d514eb8f5b1d265b24d1c016e75b20ed3b4b7da>, received 0.100000000000
```

### Step 2 Preparing Spending Transaction

Either person A or person B can do this, it doesn't matter. To avoid weird things from happening only do it for 1 transaction at a time.

**Person A** performs the usual transfer command:

```
transfer 86TmZX8EzZVjS9zNg7zAsrEQFDgcVC2qV2ZMyoWsbyK4SNB2SwMHZtMhPSsFyTmRBQUaGVF5k3qy5CMFM6Lvj7gi3AeszDag7 50
```

The output will look like:

```
Unsigned transaction(s) successfully written to file: multisig_beldex_tx
```

Check in the folder where you started `beldex-wallet-cli` from. There should be a file named `multisig_beldex_tx`.

**Person A** will send the file `multisig_beldex_tx` to the Person B. **Person A** can send this file through email or alternatively use the transfer.sh commands outside of the wallet:

```
curl --upload-file ./multisig_beldex_tx https://transfer.sh/multisig_beldex_tx
```

If Person A chooses to use transfer.sh command to send the file to Person B they will receive a `<link>` to pass to Person B.

**Person B** must finish the signature. **Person B** copies/downloads the file to the same folder from where he started (or will start) `beldex-wallet-cli`.

**Person B** can run the command to download the file to the `beldex-wallet-cli` directory.

```
curl https://transfer.sh/CJqnM/multisig_beldex_tx -o multisig_beldex_tx
```

Replacing `https://transfer.sh/CJqnM/multisig_beldex_tx` with the link provided by Person A.

Then, **Person B** runs the command:


```
sign_multisig multisig_beldex_tx
```

A prompt will be displayed to allow person B to check the transaction before signing:

```
Loaded 1 transactions, for 108.082287779, fee 0.061108880, sending 50.000000000 to 86TmZX8EzZVjS9zNg7zAsrEQFDgcVC2qV2ZMyoWsbyK4SNB2SwMHZtMhPSsFyTmRBQUaGVF5k3qy5CMFM6Lvj7gi3AeszDag7, 58.021178899 change to 86ScXhWpAG2aUHmFemwvn4HddHA5GQ4u6MvYsW2hVteJSwLJXCEhk2aVp4XzyqGmvyUqc3w8fwWwg6szGEytUSx51C6WQ3er8, with min ring size 10, no payment ID. Is this okay? (Y/Yes/N/No):
```

If ok, answer `Y`, and the output will look like:

```
Transaction successfully signed to file multisig_beldex_tx, txid 3b03b16c79eaa5564171ae88242c4cdb1f9e0b41fc3de949c6524c5026a3f3bb

It may be relayed to the network with submit_multisig
```

Finally, **person B** submits the transaction to the network by commanding:

```
submit_multisig multisig_beldex_tx
```
There will be a confirmation prompt:

```
Loaded 1 transactions, for 108.082287779, fee 0.061108880, sending 50.000000000 to 86TmZX8EzZVjS9zNg7zAsrEQFDgcVC2qV2ZMyoWsbyK4SNB2SwMHZtMhPSsFyTmRBQUaGVF5k3qy5CMFM6Lvj7gi3AeszDag7, 58.021178899 change to 86ScXhWpAG2aUHmFemwvn4HddHA5GQ4u6MvYsW2hVteJSwLJXCEhk2aVp4XzyqGmvyUqc3w8fwWwg6szGEytUSx51C6WQ3er8, with min ring size 10, no payment ID. Is this okay? (Y/Yes/N/No):
```

If ok, answer `Y`, and the transaction will be sent. The output will look like:

```
Transaction successfully submitted, transaction <3b03b16c79eaa5564171ae88242c4cdb1f9e0b41fc3de949c6524c5026a3f3bb>
```

The **person B** could also send the signed TX to person A, who could then submit it to the network himself.

If you want to make another one, you have to go back to step 1 of spending (sync the key images again).

>Note on folders and file locations, as it could create some confusions. The wallet will look for the files and export them to the folder from where it was started, ie where your command prompt / shell was when you called `beldex-wallet-cli`. It may or may not be the same folder as your actual wallet files or `beldex-wallet-cli`, depending on how you go about it.

>For example, your wallet could be on some USB drive like `f:\temp\`, and your wallet software on `c:\beldex-windows-x64\` and your shell working folder could be `c:\`.

>If you remain in `c:\` with the shell, you could start the wallet by its full path and specify the wallet file location: `c:\beldex-windows-x64\beldex-wallet-cli.exe --wallet-file f:\temp\mywallet`. In this case, all the import/export stuff would be read/written to `c:\` because that's still your shell's working folder.

>It would be probably feel more natural to cd into the wallet folder. Do `f:` to change drive and then `cd f:\temp\`. Then, simply start the wallet from that location by its full path again: `c:\beldex-windows-x64\beldex-wallet-cli.exe --wallet-file mywallet`. Notice how you don't have to write the full wallet path now as you're already there with your shell. In this case, all the files mentioned above would be written or read from the same folder as the wallet files.

Source:

[Monero Stackexchange: How to use Monero Multisigniture Wallets](https://monero.stackexchange.com/questions/5646/how-to-use-monero-multisignature-wallets-2-2-2-3)