# Beldex M/N Multisig

First, the wallet to be converted to multisig must be empty. It is best to use a brand-new wallet for the purpose, although not required. It is strongly advised to make a copy of the wallet files first, just in case something goes wrong.

## Overview

In short, the process is:

**Wallet Creation**

1.  All parties command `prepare_multisig` and send data to ALL other parties
    
2.  All parties command `make_multisig <threshold> <data1> <data2> .... <dataN>` and send 2nd batch of data to ALL other parties
    
3.  All parties command `finalize_multisig <data1> <data2> ...... <DataM>` with the data from ALL other parties.

**Receiving**

1.  All parties can type address to see the created multisig wallet address. The address will, of course, be the same for all parties since they're all watching the same wallet.  

**Preparation for Sending**

1.  To prepare for sending all parties command `export_multisig_info <filename>` and send the file to all other parties
    
2.  To complete preparation, all parties command `import_multisig_info <filename1> <filename2> ..... <filenameM>` and import files from other parties

**Sending**

1.  To send, any party can use the usual transfer command, but the result will be a file named `multisig_beldex_tx` which must be sent to any 1 other signer
    
2.  The other party commands `sign_multisig multisig_beldex_tx` and the file is updated with the signature.
    
3.  The completely signed file is pushed to the network with use of `submit_multisig multisig_beldex_tx`.

Below is a step-by-step walkthrough.

## Wallet Creation

Requirements:

-   `N` empty `beldex-wallet-cli` wallets.
    
-   All parties wallets connected to a `beldexd`.
    
-   Private communication channel.
    
### Step 1 - Prepare Multisig

All `N` people should open up their `beldex-wallet-cli` and generate a new wallet. Make sure you do not have any $beldex within your wallet.

The **1st, 2nd, 3rd**, and so on, up to the `N`th person commands in their `beldex-wallet-cli`:

```
prepare_multisig
```

The output will be something like:

```
MultisigV1cR7X7ZAfa5ncRmQv1hpt4P1DmmnhinhokhDMqsmuWXmHFrb6xUr3FtBGygCfMScxnKJvXK1vvPNahXNWfYWVquieBErr98sFtgs24c2YuYrQT78uxV8oYx1A9bKeHSUfYzCniN5kMznEfvKCw3FiomjLvw364gg98ZWp16zA7pUVozid  
Send this multisig info to all other participants, then use make_multisig <threshold> <info1> [<info2>...] with others' multisig info  
This includes the PRIVATE view key, so needs to be disclosed only to that multisig wallet's participants
```

Copy the entire line `Multisig…...Vozid` and be sure to capture the whole thing when copying.

Each person must send their `Multisig…...arg` to each other person, it is suggested to send this information through a private comunication channel.

### Step 2 - Make Multisig

All `N` people now have the `Multisig...arg` text from the other `N-1` people. With that, each of them can create their part of the multisig wallet. Before you proceed, note that the wallet will lose access to the underlying wallet when converted to multisig. This is not really a problem, since we started with an empty wallet, and if all goes OK with this step, you won't ever need it unless you want to go through the process again for whatever reason (like HDD died, but you have the seed mnemonic of the underlying wallet and want to reconstruct the multisig wallet).

**Person 1** commands:

```
make_multisig <threshold> <data person 2> <data person 3> ..... <data person N>
```

Where `<threshold>` is the number of signers required out of the `N` people, `<data person 2>` is the output provided by Person 2, and `<data person 3>` is the output provided by Person 3, and `<data person N>` is the output provided by the `N`th person.

This is the process for M of N multisig wallets, For the below example we will show a 2 of 3 multisig wallet.

This should look similar to:

```
make_multisig 2 MultisigV12EHtuvxFyAYDNcDsbDqWHDfkRr4JZchSdf8eZQSFwiMKDk15CYEJeQyEwtSnqUZdRr2BsEaT9z2biUdDTEQM4T3N625owvKMDoyhbRj3bwkBtceLKimap8DBAiUmSABpdf62HnPYiRtLW4JdVFmfqjndhWjYBypx1duvpi3qwfSrBY9a MultisigV1TqQ8Gt5Sb3GYtVJa1fQrK7e7hPm59XbooNvLxPSBR4856bW9jtD1hEyWy4yULKrX7reZZ6vrKdBCdSdk4nfApCGYJAA2WP4pKNwHDyKTuLEeuoDhqno8keEVeEF9AZsWXvng1avUTRREmy11h8wu8pdjopC4AguQKiHCJCN7aT9W6b8C  
```

Notice how there are 2 strings starting with `Multisig....arg`. One is from person 2 and other from person 3, if their is 5 different people their would be 4 different strings of `Multisig....arg`. The number at the beginning is the minimum required number of signatures. Since it's a 2/3 scheme - it's 2. 

To reiterate, for a 5/8 scheme which means there are 8 people who can sign and 5 people must sign to authorise a transaction out of the Multi signature wallet. In this circumstance, the command each person would run has a `<threshold>` that equals 5 and 7 strings of `multisig...arg`.

The output from the `make_multisig` command will be similar to:

```
Another step is needed  
MultisigxV1PKCwmVrucV8bXi18VnHFqRXcnAq4osFL3ahzPHCiN48zhs28u6jmEhy7ktZbUEGfRtTuFjjKzJYb61fnFwnysBBnNXsUtCgFMXPa7FyNKVy2AnUg3ePEnKqWkgKVvA81axTS8r9EX1DmVPXgFKkFzw4Yj4ZtMcJVo77b5ayuMzjFtsaijko9X2bjd9AVfFVGBFMCSLa4xXhNVNz19CTUJx5gpoPG  
Send this multisig info to all other participants, then use finalize_multisig <info1> [<info2>...] with others' multisig info
```

With any M of N schemes there's an additional step to be done here. The new `Multisig...arg` info that was just outputted must be passed to ALL other participants (For person 1 they must send it to persons 2 & 3 ... all the way up to person N).

Persons N sends the new output to all other persons.

### Step 3 - Finalize Multisig

Here we do one last command to make the wallet ready for receiving. It requires the 2nd batch of `Multisig…....arg` strings received from other parties.

**Person N** will run the command:

```
finalize_multisig MultisigxV1Vg1tsRLurvAc5aSA9Hd9God3MQhijCFoE1rPDFzx7ufwhs28u6jmEhy7ktZbUEGfRtTuFjjKzJYb61fnFwnysBBnfYm4xJWcJ4qM4khSb2KkyAKDuT39pTvdmemhojNjeYCmgSQ1NZLyBj48R1tVpiGNxa7TDnGbSgLuKBq35AX6jfu5PECAcDDn22CFQbJZip7xnBbn89Szzh27xeozfxcLiqqm MultisigxV14xDZBGACz3iUh2aVKGE5q5VzcvJdg2qCvZECgUWCdy5QNXsUtCgFMXPa7FyNKVy2AnUg3ePEnKqWkgKVvA81axTSfYm4xJWcJ4qM4khSb2KkyAKDuT39pTvdmemhojNjeYCmCNaRSsDEcemLLL8wCvzsy5R6hhkhWLYkD9vhZwprSFFKMZ7tfRko2VfMBoKQhB7PKXbf1npk2xceVKu2y7kExywb
```

Unfortunately the wallet will not display an output at this point. There's no indication that the process was successfully completed (for now). All N persons do the same, and all N wallets will show the same address after this step.

Now each person run the command:

```
address
```

And each N people of the multisig wallet should be shown the same address in their wallet.

## Receiving

### Step 1 Fund The Multisig Account

This is simple, just send to the shared address. You can send multiple times, just like a normal wallet. You can use payment ID’s as well, or generate an integrated address to receive funds.

Best part, whomever is sending the funds won't be able to tell that the address belongs to a multisig wallet since it looks like any other Beldex address.

### Step 2 Check Multisig Account Balance

Just open the wallet and run the refresh command. Once completed, all persons can verify that the funds arrived.

**Person 1, 2**, **3** up to **N** can run the command:

```
show_transfers
```

To see incoming transfers or the following command to see the balance of the wallet:

```
balance
```

## Preparation for Spending

### Step 1 - Export Multisig

Without this step, it will not be possible to create a transaction that spends Beldex. As a minimum, the sender needs to get a partial key image from all the people who will sign the transaction with them later. They could get it from the parties immediately and then later decide with whom to sign.

**Person N** commands:

```
export_multisig_info miN
```

Where `miN` can be any filename. The output will be:

```
Multisig info exported to miN
```

The file `miN` will be located in the shell working folder*

**Person N** sends that file to other people. Persons 2 & 3 up to N do the same.

#### Optional: Step 1.2 Sending Multisig Info File with terminal - transfer.sh

It is optional to use the terminal to send each person the multisig info files.

##### Uploading Multisig Info file

**Person 1** will open up a new terminal and change to the directory `mi1` has been saved.*

**Person 1** will run the following command:

```
curl --upload-file ./mi1 https://transfer.sh/mi1
```

**Person 1** will receive the link to the file as an output, looking similar to:

```
https://transfer.sh/Ehl5q/mi1
```

**Person 1** will need to send this link to Person 2, Person 3, .... Person N. **Person 2** will need to do the same and send the link to Person 1, 3 ..... N. **Person 3** will need to do the same and send the link to Person 1, 2 ..... N. Person N will need to do the same and send the link to Person 1, 2, 3, 4, 5 ...... N-1.

##### Downloading Multisig Info file

**Person 1** should change to the directory of their `beldex-wallet-cli` and use Person 2, 3, 4 ... N’s download link to run the commands:

```
curl <link> -o <filename>
```

Replacing `<link>` with the link Person 2, 3 ... N shared with Person 1 and `<filename>` with the filename of the Multisig info file that Person 2, 3 or ... N generated, for example Person 1 will run the command:

```
curl https://transfer.sh/Iedv9/mi2 -o mi2
```

And the command:

```
curl https://transfer.sh/dfvr3/mi3 -o mi3
```

and all the way up to:

```
curl https://transfer.sh/dfvr3/mi3 -o miN
```

Likewise, Person 2, 3 .... and N should do the same, changing directories to their `beldex-wallet-cli` and downloading with the alternative Persons download link, and filename.

```
curl https://transfer.sh/Ehl5q/mi1 -o mi1
```

### Step 2 - Import Multisig

Now, they must all import each other's file so they can be ready to make a TX later.

For example, **Person 2** commands:

```
import_multisig_info mi1
```

```
import_multisig_info mi3
```

```
import_multisig_info miN
```

The wallet will look for files in the shell working folder* and if the files are found the output will look like:

```
2 outputs found in mi1  
Height 56156, transaction <88ba687dc79a0b39e6de6d0763eda8363d33d9f58ec9a096171bd9a7f1dae873>, received 0.100000000000  
Height 56156, transaction <d6ac845b9400759525519cdc5d514eb8f5b1d265b24d1c016e75b20ed3b4b7da>, received 0.100000000000
```
**Persons 1**, **3 .... and N** do the same.

## Spending

### Step 1 - Transfer (Preparing Unsigned Transaction)

Any of the multisig wallets can start a transaction, it doesn't matter. To avoid weird things from happening only do it for 1 transaction at a time. If anything weird happens, do the step 1 & 2 again to fix.

For example, let's say that Person 3 will make the TX.

Person 3 performs the usual transfer command:

```
transfer bxTmZX8EzZVjS9zNg7zAsrEQFDgcVC2qV2ZMyoWsbyK4SNB2SwMHZtMhPSsFyTmRBQUaGVF5k3qy5CMFM6Lvj7gi3AeszDag7 50
```

The output will look like:

```
Unsigned transaction(s) successfully written to file: multisig_beldex_tx
```

Check in the folder where you started `beldex-wallet-cli` from. There should be a file named `multisig_beldex_tx`.

Send the file `multisig_beldex_tx` to one of the people who will sign the TX.

**Person 3** will send the file `multisig_beldex_tx` to the Person 1, 2 or N. **Person 3** can send this file through email or alternatively use the transfer.sh commands outside of the wallet:

```
curl --upload-file ./multisig_beldex_tx https://transfer.sh/multisig_beldex_tx
```

If Person 3 chooses to use transfer.sh command to send the file to Person 1 or 2 they will receive a `<link>`.

**Person 1** or **2** must finish the signature. Person 1 or 2 copies/downloads the file to the same folder from where he started (or will start) `beldex-wallet-cli`.

**Person 1** or **2** can run the command to download the file to the `beldex-wallet-cli` directory.

```
curl https://transfer.sh/CJqnM/multisig_beldex_tx -o multisig_beldex_tx
```

Replacing `https://transfer.sh/CJqnM/multisig_beldex_tx` with the link provided by Person 3.

### Step 2 - Sign Multisig

Let's say Person 2 was picked as the partner. They must finish the signature. Person 2 copies the file to the same folder from where he started (or will start) `beldex-wallet-cli`.

Then, **Person 2** commands:

```
sign_multisig multisig_beldex_tx
```

and they will be prompted to check it first:

```
Loaded 1 transactions, for 108.082287779, fee 0.061108880, sending 50.000000000 to bxTmZX8EzZVjS9zNg7zAsrEQFDgcVC2qV2ZMyoWsbyK4SNB2SwMHZtMhPSsFyTmRBQUaGVF5k3qy5CMFM6Lvj7gi3AeszDag7, 58.021178899 change to bxScXhWpAG2aUHmFemwvn4HddHA5GQ4u6MvYsW2hVteJSwLJXCEhk2aVp4XzyqGmvyUqc3w8fwWwg6szGEytUSx51C6WQ3er8, with min ring size 10, no payment ID.

Is this okay? (Y/Yes/N/No):
```

If ok, answer `Y`, and the output will look like:

```
Transaction successfully submitted, transaction <3b03b16c79eaa5564171ae88242c4cdb1f9e0b41fc3de949c6524c5026a3f3bb>
```

If the threshold is greater than 2 another `multisig_beldex_tx` file will need to be signed by the amount of signers required.

### Step 3 - Submit Multisig

Finally, person with the final signed file submits the transaction to the network by commanding:

```
submit_multisig multisig_beldex_tx
```

There will be a confirmation prompt:

```
Loaded 1 transactions, for 108.082287779, fee 0.061108880, sending 50.000000000 to bxTmZX8EzZVjS9zNg7zAsrEQFDgcVC2qV2ZMyoWsbyK4SNB2SwMHZtMhPSsFyTmRBQUaGVF5k3qy5CMFM6Lvj7gi3AeszDag7, 58.021178899 change to bxScXhWpAG2aUHmFemwvn4HddHA5GQ4u6MvYsW2hVteJSwLJXCEhk2aVp4XzyqGmvyUqc3w8fwWwg6szGEytUSx51C6WQ3er8, with min ring size 10, no payment ID.

Is this okay? (Y/Yes/N/No):
```

If ok, answer `Y`, and the transaction will be sent. The output will look like:

```
Transaction successfully submitted, transaction <3b03b16c79eaa5564171ae88242c4cdb1f9e0b41fc3de949c6524c5026a3f3bb>  
```

You can check its status by using the `show_transfers` command.

The person 2 could also send the signed TX to person 3, who could then submit it to the network himself.

If you want to make another one, you have to go back to preparation for spending step (sync the key images again).

> The wallet will look for the files and export them to the folder from where it was started, ie where your command prompt / shell was when you called `beldex-wallet-cli`. It may or may not be the same folder as your actual wallet files or `beldex-wallet-cli`, depending on how you go about it.

>For example, your wallet could be on some USB drive like `f:\temp\`, and your wallet software on `c:\beldex\` and your shell working folder could be `c:\`.

>If you remain in `c:\` with the shell, you could start the wallet by its full path and specify the wallet file location: `c:\beldex\beldex-wallet-cli.exe --wallet-file f:\temp\mywallet`. In this case, all the import/export stuff would be read/written to `c:\` because that's still your shell's working folder.

>It would be probably feel more natural to `cd` into the wallet folder. Do `f:` to change drive and then `cd f:\temp\`. Then, simply start the wallet from that location by its full path again: `c:\beldex\beldex-wallet-cli.exe --wallet-file mywallet`. Notice how you don't have to write the full wallet path now as you're already there with your shell. In this case, all the files mentioned above would be written or read from the same folder as the wallet files.

Source:

[Monero Stack Exchange: how to use monero multisigniture wallets](https://monero.stackexchange.com/questions/5646/how-to-use-monero-multisignature-wallets-2-2-2-3)