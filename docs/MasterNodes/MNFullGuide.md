# Full Guide on Master Nodes

This document will tell you exactly how to set up and operate a Master Node for the Beldex Project. This document was written with non-developers in mind, so people new to linux or command line operations should be able to follow along without any trouble. 

If you feel confident around servers and the CLI, then skip to the [Express Setup Guide](#express-setup-guide)

You can of course run the Beldex software on any operating system that you can get it to build on, but for the purposes of this document, the instructions apply to running a Master Node on a remote Ubuntu 16.04 server. If that isn’t what you want to do, syntax and server set up will of course differ according to whatever OS you choose to run your Master Node from.

### Summary of Beldex Master Node Requirements

Full summary of Beldex Master Node Requirements. This may change depending on Master Node functionality, so you should check here regularly, or follow our [Telegram](https://t.me/BeldexCommunity)/[Discord](https://discord.gg/DN72VN) announcements channel.

|Spec|Note|
|---|---|
|Latest Binary|[Beldex Feng Huang v3.1.3](https://github.com/beldex-coin/beldex/releases/latest)|
|Software| Ubuntu 16.04|
|Storage | 30-50gb|
|Ram | 2-4 gb|

## Table of Contents

- [Overview of Master Nodes](#Overview)
- [New User Guide](#new-user-guide)
    - Step 1 [Server](#step-1-get-a-server)
    - Step 2 [Server Prep](#step-2-prepare-your-server)
    - Step 3 [Download Binaries](#step-3-download-the-beldex-binaries)
    - Step 4 [Run the Beldex Daemon](#step-4-run-the-service-node-daemon)
    - Step 5 [Open a Beldex Wallet](#step-5-getopen-a-wallet)
    - Step 6 [Register Node](#step-6-service-node-registration)
    - Step 7 [Check Registration](#step-7-service-node-check)
- [Express Setup Guide](#express-setup-guide)

## Overview

-   Master Nodes are full nodes on the Beldex network

-   Full nodes become Master Nodes when the owner [locks the required amount of Beldex](StakingRequirement.md) and submits a registration transaction.

-   Once accepted by the network, the Master Node is eligible to win block rewards.

-   Multiple participants can be involved in one Master Node and can have the reward automatically distributed

It is also worth noting that Master Nodes are quite basic at the moment, and operators will need to stay up to date with new updates to keep in line with software and hardware requirements. Once all of the updates are out, Master Nodes will also:

-   Route end user’s internet traffic, either as an exit node or relay in a novel mixnet.

-   Receive, store and forward encrypted user messages.

-   Monitor other Master Nodes and vote on their performance.

-   Be called into quorums which give them authority over instant transactions ([Blink](../BeldexServices/Blink.md)).

-   Act as remote nodes for users.

Once these features come out, Master Node operation will require better servers, particularly when it comes to bandwidth. For the purposes of this guide, however, we will only consider the current requirements.

## New User Guide

This section of this guide is for new users to servers and the CLI interface. 

### Step 1 - Get a Server

Righto! Let’s get started. Choosing where to set up a Master Node is the biggest choice you will make when running a Master Node. There are a number of things to consider. Because you will be locking up funds for 30 days (2 days for testnet) at a time, you will want to ensure that your server has:

-   A stable, relatively fast connection to be able to respond to ping requests to avoid being booted off the network.

-   We recommend 2GB of RAM to cope with running the software reliably (*Note: This requirement may be much greater once services are live*). 1GB is fine for testing.

-   At Least a 20GB SSD or Hard disk drive, this will be used to store the blockchain (*Note: to future proof yourself against blockchain growth and message storage we recommend a 30 - 40 GB drive*).

-   A stable power supply. If your server goes down during the staking period, you may get kicked off the network, and not receive rewards while your funds are still locked for the remainder of the staking period.

For most users, we assume that your home internet connection is relatively slow (< 4MB/s down and up) and probably lacks support for external connections. If this is the case, you will probably not want to run a Master Node from your home in the long term, as this could cost you if and when you get booted off. Since we’re just testing at the moment, you could run it from home anyway, but for this guide we’ll avoid it.

Typically, the easiest and cheapest way to host a server outside of your home is to use a Virtual Private Server (VPS). There are thousands of options when it comes to VPS providers, but for now, just about any one will do. In the future, selection will be made more difficult because most providers will not allow exit node traffic, so we have compiled a list of exit node friendly providers to choose from if you want to stay with your provider for more than a few months.

|Hosting Provider| Product Name | Cost Per Month $USD | Bandwidth Provided | Exit Friendliness Rating |
|--------------------|-----------------|----------------------------|--------------------|-------|
|Netcup|VPS 1000 G8|10.50|30 - 35 MiB’s|5 / 10
|Online.net|Start-2-S-SSD|13.99|15 - 17 MiB’s|9 / 10|
|Scaleway|START1-M|9.33|20 - 25 MiB’s|7 / 10
|OVH|VPS SSD 2|7.61|10 - 15 MiB’s|9 / 10|
|Leaseweb|Virtual Server XL|34.45|30 - 35 MiB’s|5 / 10
|Digital Ocean|2 GB, 2 vCPUs|15|9 - 11 MiB’s|8 / 10
|Feral Hosting|Neon Capability|19.68|9 - 11 MiB’s|9 / 10
|Trabia|VDS-8G|38.54|9 - 11 MiB’s|8 / 10
|Hetzner|EX41-SSD (30 TB)|39.71|80 - 40 MiB’s|4 / 10

>Note: We do not officially endorse any of these providers, this list is simply illustrative of some of the options currently available*

Try not to pick the first one off the list. Do some digging and see which one looks the best to you, what your budget is, and what the latency is like for you based on the server location that you choose.

When selecting your VPS’ operating system, choose Ubuntu 16.04 64 bit or Ubuntu 18.04 64 bit if you want to follow this guide. If you feel more confident or wish to run your server on another distribution or operating system, the Beldex commands in this guide will still apply.

### Step 2 - Prepare your Server

Every provider has a slightly different way of issuing you access to your new VPS. Most will send an email with the IP address, root username, and a root password of the VPS.

To access your server, you will need a SSH client for your operating system. Because we’re on Windows today, we’ll download PuTTY, Mac users can also use PuTTY. If you’re a Linux user, you probably don’t want us telling you where to get a SSH client from.

To connect to our VPS we will need to paste the IP address into the SSH client’s “Host Name (or IP address)” input box and click the “Open” button. The Port number can usually just be left as `22`.

<center>![Putty window](../assets/snode1.JPG)</center>

A terminal window will now appear prompting for your log-in details, username(root) and password, which were provided by your VPS provider. When entering your password, nothing will visually appear in the terminal. This is normal. Hit enter when it’s typed or pasted, and you should be logged in to your VPS.

#### Create a non-root User

Best practice when running a public server is to not run your software as the root user.  Although
it is possible to do everything as root, it is strongly recommended that you create a non-root user
on our VPS by running the following command:

```
adduser <username>
```

Replacing `<username>` with a name you will log-in with. For this user-guide we will use `mnode` as our username.

```
adduser mnode
```

The terminal will prompt you for a new password for our newly created user. Use a secure password that is different password from the root password.

Once the password has been set, the terminal will prompt for a few details about the individual running the user. You can just hit enter through each of the inputs as the details are not important for the purposes of running a Master Node.

Once that’s done, run the following two commands to give our new account admin privileges and to change to such account.

```
usermod -aG sudo mnode
```

```
su - mnode
```

Before we proceed further, it is advised to close your terminal and reopen PuTTY to set up a saved session with our mnode user. Your SSH client will have a load and save session function. For PuTTY we will need to type in our VPS IP address again, on the same screen type mnode under “Saved Session”. Click on “Data” under the drop-down menu “Connection”, and type in mnode (or your username defined before) into the input box “Auto-login username”. Go back to your session screen, where we entered the IP address, and click “Save”. You can load this session whenever you want to check on your Master Node.


#### Hot Tips for using the Console

Consoles don't work like the rest of your computer. Here are some basic tips for navigating your way around the command line!

- Don't try copying something by using the usual Ctrl + C hotkey! If you want to copy something, do so by highlighting text and then right clicking it. Pasting works by right clicking a blank area in the console.
  
- If you want to kill a process or stop something from running, press Ctrl + C. (This is why you shouldn't try copying something with this hotkey.)

- You can always check the directory you are in by typing `pwd` and list its contents by typing `ls`.
    
- You can always return to your home directory by typing `cd`.

- You can move into a given directory by typing `cd <name>` or move back up one level by typing `cd ..`.

- PuTTY allows you to easily duplicate or restart a session by right clicking the top of the window. Handy if you’re trying to do a few things at once.

Once we have logged in correctly to the VPS for the first time, the VPS may be configured to prompt for a new password for the root account. The terminal will require you to enter the new password twice before we can start running commands.  If you aren't prompted for a new `root` password but want to change it anyway, type `sudo passwd`.  Choose something very secure!

#### Server Preparation Continued

We should update our package lists, the below command downloads the package lists from the repositories and "updates" them to get information on the newest versions of packages and their dependencies. It will do this for all repositories and PPAs.

```
sudo apt update
```

You will notice a bunch of package lists were downloaded, once this is complete run the below command to fetch new versions of any packages we currently have installed on the system.

```
sudo apt upgrade
```

You will be prompted to authorise the use of disk space, type `y` and enter to authorise.

If you are prompted during the upgrade that a new version of any file is available then click the up and down arrows until you are hovering over `install the package maintainer’s version` and click enter.

<center>![Terminal window](../assets/snode2.JPG)</center>

Alright, good to go. Our server is now set up, up to date, and is not running as root. On to the fun part!

### Step 3 - Download the Beldex Binaries

In order to download and extract the Linux binaries, we need to make sure a couple tools are
installed:

```
sudo apt install wget unzip
```

Now download the Linux binaries by running the following command:

```
wget <link>
```

Where `<link>` is the download link of the latest linux release. To find the link go to [https://github.com/beldex-coin/beldex/releases/latest](https://github.com/beldex-coin/beldex/releases/latest), right click the latest linux release and click `Copy Link Location`.

Your command should look something like:

```
wget https://github.com/Beldex-Coin/beldex/releases/download/v3.1.3/beldex-linux-x64-v3.1.3.zip
```

To unzip the downloaded zip file run the following command (changing 2.0.4 to whatever version you
downloaded above):

```
unzip beldex-linux-x64-v3.1.3.zip
```

You will see something like this:

```
Archive: beldex-linux-x64-v3.1.3.zip
   creating:beldex-linux-x64-v3.1.3/
  inflating:beldex-linux-x64-v3.1.3/beldex-blockchain-ancestry  
  inflating:beldex-linux-x64-v3.1.3/beldex-blockchain-depth  
  inflating:beldex-linux-x64-v3.1.3/beldex-blockchain-export  
  inflating:beldex-linux-x64-v3.1.3/beldex-blockchain-import  
  inflating:beldex-linux-x64-v3.1.3/beldex-blockchain-mark-spent-outputs  
  inflating:beldex-linux-x64-v3.1.3/beldex-blockchain-stats  
  inflating:beldex-linux-x64-v3.1.3/beldex-blockchain-usage  
  inflating:beldex-linux-x64-v3.1.3/beldex-gen-trusted-multisig  
  inflating:beldex-linux-x64-v3.1.3/beldex-wallet-cli  
  inflating:beldex-linux-x64-v3.1.3/beldex-wallet-rpc  
  inflating:beldex-linux-x64-v3.1.3/beldexd  
```

Note that they are unzipped into the `beldex-linux-x64-v3.1.3` folder; you can check they are unzipped by running the following to change into the folder and then listing the files:

```
cd beldex-linux-x64-v3.1.3
ls
```

We now want to create a "symlink" to the extracted `beldex-linux-x64-v3.1.3` folder:

```
cd
ln -snf beldex-linux-x64-v3.1.3beldex
```

This creates a virtual `beldex` folder that points to the `beldex-linux-x64-v3.1.3` folder.  This isn't
strictly necessary, but will help with upgrades in the future: when you want to upgrade (for
example, to a future 3.0.0 release) you can just repeat everything in this step again and the `beldex`
symlink will be updated to the new folder containing the 3.0.0 binaries.

Excellent! We now have all of the necessary files to get this show on the road!

> *NOTE: If you’re nervous about trusting the binaries or the download link, you should build it from source yourself. Instructions for that can be found in the README of [https://github.com/beldex-coin/beldex](https://github.com/beldex-coin/beldex)*

### Step 4 - Run the Master Node Daemon

At this point you can run the Beldex daemon directly in your terminal, but this is not a viable
approach to running it as a service node: when you close PuTTY the program running inside it will
*also* shut down, which is no good for a service node.

Instead we will configure the Beldex daemon as a system service which makes it automatically start up
if the server reboots, and restarts it automatically if it crashes for some reason.

<ol>
<li>Create thebeldexd.service file:
<pre><code>sudo nano /etc/systemd/system/beldexd.service</code></pre>
</li>
<li>Copy the text below and paste it into your new file:</li>
</ol>
<pre><code>[Unit]
Description=beldexd service node
After=network-online.target

[Service]
Type=simple
User=mnode
ExecStart=/home/mnode/beldex/beldexd --non-interactive --service-node
Restart=always
RestartSec=30s

[Install]
WantedBy=multi-user.target
</code></pre>

<ol start="3">
<li>If you chose a username other than <code>mnode</code> then change <code>mnode</code> in the <code>User=</code> and <code>ExecStart=</code> lines to the alternative username.</li>
</ol>

>(If you want to run a testnet service node, append ` --testnet` to the end of the ExecStart line.  Alternatively, if you want to be able to run both a testnet and mainnet service node simultaneously
>you can use two service files: `beldexd.service` and `beldexd-testnet.service` and add ` --testnet` to the `ExecStart=` line in the latter.  You would then use `beldexd-testnet.service` instead of
>`beldexd.service` in the commands below when you want to control the testnet service node.)

<ol start="4">
<li>
<p>Once completed, save the file and quit nano:
CTRL+X -&gt; Y -&gt; ENTER.</p>
</li>

<li>
<p>Reload systemd manager configuration (to make it re-read the new service file):</p>
<pre><code>sudo systemctl daemon-reload</code></pre>
</li>

<li><p>Enable beldexd.service so that it starts automatically upon boot:</p>
<pre><code>sudo systemctl enablebeldexd.service</code></pre>
</li>

<li>
<p>Start beldexd.service:
<pre><code>sudo systemctl start beldexd.service</code></pre></p>
</li>
</ol>

The daemon will now start syncing. You won’t be able to do much if it hasn’t synced.

To watch the progress at any time you can use the following command (hit Ctrl-C when
you are done watching it).  You should see it syncing the blockchain:

```
sudo journalctl -u beldexd.service -af
```

Alternatively you can ask the daemon to report its sync status using the following command:

```
~/beldex/beldexd status
```

### Step 5 - Get/Open A Wallet

While we wait for the daemon to sync, we can now get a wallet going. 

>*** You do not have to run this wallet on the server and you should not! Download the software and run it from elsewhere for security reasons! ***

You can run the CLI wallet (Command Line Interface wallet) on any other computer, including your home computer to avoid leaving your wallet on the server.

However, if you do want to run the CLI wallet on another computer, you will either need to run another daemon on that local machine or use a remote node (uk.beldex.cash:22020, for example). There is also a list of trusted remote nodes in the Beldex Project Discord channel under #links-and-resources.

```
./beldex-wallet-cli --daemon-address <insert address here>
```

Or on windows:

```
beldex-wallet-cli.exe --daemon-address <insert address here>
```

If you are made of money and are willing to take the small risk of losing all of your funds, you can continue running the wallet inside the Master Node VPS. So we don't have to talk about a myriad of other operating systems or potential user cases, the rest of this guide will assume you are running the wallet in the same VPS.

As such, it’ll probably save us time to open a second PuTTY session. You can do this by right clicking the window of the current PuTTY session and clicking “Duplicate Session.”

Log in as the non-root user that we set up before, in our case `mnode`, and launch the wallet using:

```
~/beldex/beldex-wallet-cli
```

> If you are on testnet run the command with the --testnet flag: `~/beldex/beldex-wallet-cli --testnet`

When `beldex-wallet-cli` first runs, it will request for you to specify a wallet name. Assuming we haven't created one yet, we will use the e.g. name `MyWallet`

Because this is the first time we have used the name `MyWallet` the client will prompt us to create a new wallet. Type `y` and click return to continue.

The `beldex-wallet-cli` has generated us a wallet called `MyWallet` and is now prompting us for a password.

> Note:
> When typing the password, the characters will not appear. It will seem as if you are typing and no text is appearing however the terminal is logging every character you type including if it is capitalised or lowercase.

> Write down your wallet name and password on a piece of paper as this information will be required every time we want to enter our wallet.

> Use a password with uppercase letters, lowercase letters, numbers, symbols and make the password at least 9 characters long.

Once we have chosen our password for the wallet we must choose our language. For the purposes of this user guide I suggest you use English by typing in `1` and clicking return.

The CLI will generate and spit out several lines of text. The first two lines of text show your wallet public address. This address can be shared, will be used to receive Beldex to your wallet, and will be used during the preparation and registration of our Master Node. All Mainnet Beldex public addresses start with an L and are followed with a string of characters, Testnet Public addresses start with a T. The public address shown will be your primary address, however multiple public addresses can be generated from this primary address.

Line 13 to 17 show your 25-word mnemonic (“new-monic”) seed. The seed is used to easily backup and restore your wallet without needing any other information. At this stage, grab a pen and paper, and write down your 25 words in order. Store the piece of paper in a safe and secure place, if your words are stored in a text file on your computer or stored online, you increase your risk of someone else getting control of your wallet.

It is at this point that we should get some Beldex in the wallet. The amount of Beldex required to run a node is 10,000 BDX. If you do not have enough you will have the option to join in or run your own Master Node pool.


**If you are staking please do not use Subaddresses. They are currently unsupported by the Beldex wallet.** 

We will need our address to register our Master Node later, to get your primary address type the following command:

```
address
```

Highlight the string of characters that were outputted and save this in a notepad for later use, your public address should look similar to:

```
bxdCCyDgjjbddtzwNGryRJ5HntgGYvqZTagBb2mtHhn7WWz7i5JDeqhFiHqu7ret56411ZJS7Thfeis718bVteBZ2UA6Y7G2d
```

(Note that this is an example testnet wallet address; your address will start with `L` if it is a mainnet wallet)

> *NOTE: Do not use CTRL + C to copy your address, it will close the wallet down. Simply highlight the address and this will automatically save the portion you highlighted into your clipboard.*

Once you have enough Beldex in this wallet, just leave it open, we’ll come back to it in a minute.


### Step 6 - Master Node Registration
The next part of the guide will split into two sections: 
* If you are an individual staker and do not require any other contributors to run your Master Node jump into **6.1 - individual Staking**.
* If you want to run a pooled Master Node or contribute towards a pool jump into **6.2 - Pool Staking**

---
#### 6.1 - Individual Staking
If you want to run the Master Node as an individual you will require the following things.

* A fully synchronized, up-to-date Beldex daemon running with the `--service-node` flag (see step 4).
* A `beldex-wallet-cli` primary address with enough Beldex in your account to meet the Master Node Staking Requirement (see step 5).

Now if we have the two above items we can proceed to our daemon to register our Master Node.

Log in (if not already connected) as the `mnode` user on the VPS running the service node, then start
the registration process by running the following interactive command:

```
~/beldex/beldexd prepare_registration
```

The daemon will output the current staking requirement and prompt you with an input to clarify whether you are an individual staker or you will be running a pool. Type `y` and click enter as we will be the sole staker.

The daemon will now prompt us for the Beldex address of the operator. If you followed step 5 you should have this address saved in a notepad, if not run through step 5 again to find your Beldex Address. Once we have the Beldex Address copied to our clipboard we can then right click the terminal screen to paste the address. Double check the address matches the one of your wallet then click enter if it is the same.

The daemon will now ask for a final confirmation, if you agree to the information provided type `y` and click enter.

The daemon will output a command for us to run looking similar to:

```
register_master_node 18446744073709551612 bxd9QjdbUPoW4qaWAtMeeAQtjEjE4bK3Zcfc62qLmvjQUAbXLFsYfsovTNQLLoa325iFb8UgsGxppayU8Fzc8tHFb82wCa5Hf3t 18446744073709551612 1557240134 a51e0175322944cdb456e7bffx60fb352b27bfa6dab263d8603dc24c41e934644 a581656d7d20a66a3f694b1be6321482656b2f98d1ee35ae720c1f1bb99317004d3120650654b36a56cf42e0109fea8eb4d42eea72842ce5506e009ca083e508 
```

> *NOTE: You must run the command outputed by **your** daemon and not the command shown above.*

Copy the whole line of text and paste it into your notepad as we will need to run this command in our `beldex-wallet-cli`.
If registering multiple nodes, it will likely be necessary to wait at least 10 blocks between Master Nodes before running the register Master Node command in the wallet.

You have 2 weeks from the moment of preparing the registration command on the Master Node to actually run the `register_service_node` command in the wallet, however it is advised to do it as soon as possible.

Run through step 5 once more to open our Beldex wallet (if you don't already have it open). Once we are in our wallet run the command the daemon outputted for us when we prepared our Master Node registration.

The wallet will prompt us to confirm our password, then the amount of Beldex to stake. Confirm this by typing `y` and clicking enter. 

> Note: At this point you now have locked stakes! To unlock your stake run the following

Well done! Let's continue to the next step **"Step 7 - Master Node Check"** to check if our Master Node is running.

#### 6.2 - Pool Staking

##### Minimum Contribution Rules
Infinite Staking introduces new limitations on the number of transactions that can be contributed to a Master Node, changing the minimum contribution rules for participating in the Master Node. 

Master Nodes accept at most 4 contributions, meaning the minimum contribution to a Master Node becomes:

<center>![Contribution](../assets/contribution.svg)</center>

In a pooled Master Node with reserved spots, the Minimum Contribution must be either the Reserved Amount or the Contribution determined by the above equation, whichever is larger.

<center>![Min Contribution](../assets/mincontribution.svg)</center>

A simplistic example being, if the staking requirement is 24,000 Beldex then if,

-   Operator contributes 50% of the requirement (12,000 Beldex)

-   The next contributor must contribute at least (⅓ * 12,000) Beldex i.e. 4000 Beldex to become a participant.

-   If this contributor had reserved a spot for more than 4000 Beldex, their Minimum Contribution would be that amount.
    
There are rules in the client software in place to stop users from irreversibly funding a Master Node into an invalid state.

Depending on the individual and their circumstance they will need to:

* Jump into section **[6.2.1 - Operator](#621-operator)** if they are running the daemon and hosting the pool;

* Jump into section **[6.2.2 - Pool Contributor](#622-pool-contributor)** if they are contributing to someone's Master Node.

>*NOTE: It is advised to read both sections of ***"6.2 - Pool Staking"*** to have a better understanding of the process.*

---

##### 6.2.1 - Operator

The Operator is the individual who will be hosting the pool and running the Master Node daemon, thus incurring the operating expenses encompassed by running a node.

The Operator will need to have:

* A fully synchronized, up-to-date Beldex daemon running with the `--service-node` flag (see step 4) at all times.

* A `beldex-wallet-cli` primary address with enough Beldex in their account to meet 25% of the Staking Requirement.

* 1-3 other contributors who also have a wallet (`beldex-wallet-cli` or the desktop GUI wallet) with enough Beldex in their accounts to meet 25% of the staking requirement.

* If the operator wants to reserve contribution spots for specific contributors: The address and contribution amounts the 1-3 contributors will stake.

>*NOTE: The other contributors addresses are optional to have as you can create your pool to be open to anyone to contribute to, however they are recommended to have to avoid any issues of other individuals stealing their spots.  On the other hand, a reserved contribution spot can only be filled by that contributor: if they change their mind before submitting a stake your service node will be stuck inactive, so it is recommended to use reserved contribution spots only with contributors you trust.*

Now if we have the three/four above items we can proceed to our daemon to register our Master Node.

Log in (if not already connected) as the `mnode` user on the VPS running the service node, then start
the registration process by running the following interactive command:

```
~/beldex/beldexd prepare_registration
```

The terminal will prompt the operator to specify if they will contribute the entire stake, because we are running this as a pooled Master Node we will type `n` and click enter.

Next the terminal will request the input for the operator cut. This value is between 0-100 and represents the percentage of the reward the operator will receive before the reward is distributor to the share holders. If you have agreed to a 10% operator cut with the other contributors you would type `10` and click return.

The terminal will now display the minimum reserve the operator can contribute and request the operator to input the amount in Beldex they wish to contribute. Type your desired `<operator contribution>` and click return.

Once we have set the operators desired stake amount we have the option to either leave the pool open for anyone to contribute or lock a reserve for individuals that have agreed with us to stake within our Master Node. 

---

###### Reserved Pool

If the operator wishes to reserve spots for specific contributors they should type `y` and click return. 

The terminal will now prompt the operator for the number of additional contributors they have organised to be apart of this Master Node. Type in the number of reserved contributors, not including themselves, and click return.

The daemon will now prompt us for the Beldex address of the operator. If you followed step 5 you should have this address saved in a notepad, if not run through step 5 again to find your address. Once we have the Beldex Address copied to our clipboard we can then right click the terminal screen to paste the address then click return to confirm your address.

Next the operator must input the amount of Beldex each contributor will contribute and the contributor's address.

>*NOTE: It is possible to reserve only some of the required stakes for specific contributors while leaving the remaining stake open.*

You will now be asked to confirm the information above is correct.

---

###### Open Pool

If the operator wishes to leave their pool complete open to contributions they should type `n` and click return. The terminal will prompt the operator to input their address. Once the address has been inputted the terminal will display the remaining portion that needs to be contributed by others. If you agree click `y` and hit return.

---

The daemon will display a summary of the information we entered. This is our chance for a final check over to make sure we entered in the right information. If you confirm the information is correct type `y` and click return.

The daemon will output a command for us to run within our wallet, looking similar to:

```
register_master_node 18446744073709551612 bxd9QjdbUPoW4htaWAtMAQtjEjExz4bK3Zcfc62qLmvjQUAbXLFsYfsovTNQLLoa325iFb8UgsGxppayU8Fzc8tHFb82wCa5Hf3t 18446744073709551612 1557240134 a51e0175322944cdb456e7bff60fb352b27bfa6dab263d8603dc24c41e934644 a581656d7d20a66a3f694b1be6321482656b2f98d1ee35ae720c1f1bb99317004d3120650654b36a56cf42e0109fea8eb4d42eea72842ce5506e009ca083e508 

```

> *NOTE: You must run the command outputed by **your** daemon and not the command shown above.*

Copy the whole line of text in your daemon and paste it into your notepad as we will need to run this command in our `beldex-wallet-cli`.

You have 2 weeks from the moment of registering the Master Node to run the `register_service_node` command, however it is advised to do it as soon as possible.

Before you disconnect from your VPS run the following command to get your `<Master Node Public Key>` and save it in your notepad (your contributors will need it):

```
~/beldex/beldexd print_sn_key
```

Run through step 5 once more to open our Beldex wallet. Once we are in our wallet run the command the daemon outputted for us when we prepared our Master Node. The wallet will prompt us to confirm our password, then the amount of Beldex to stake. Confirm this by typing `y` and clicking enter.


Once this command completes your staking transaction will be sent to be included on the blockchain.
It may take a few minutes for the transaction to be mined into a block; you can check the status
using

```
~/beldex/beldexd print_mn_status
```

or by looking for your `<Master Node Public Key>` in the "Master Nodes Awaiting" section on [explorer.beldexcoin.com](http://explorer.beldexcoin.com)

Once the master node registration is received you can send the `<Master Node Public Key>` to your contributors with the amount of Beldex they are required to stake.

> *NOTE: the final amount will typically be slightly lower than what you entered in the prepare_registration command.  This is expected: the required amounts are based on the registration block height which has usually advanced by a couple blocks between the time you prepared the registration and the time it gets mined into the blockchain.*

At this point we will need to wait until all contributors have staked before the service node activates and becomes eligible to receive rewards.

---

##### 6.2.2 - Pool Contributor

The pool contributor must first receive the Master Node Pubkey and the requirements (amount ofbeldex to send) from the Master Node Operator.

> **If you are staking please do not use Subaddresses. They are currently unsupported by the Beldex wallet** 

The pool contributor must have downloaded the necessary binaries, is running a daemon or is connected to a remote node, has generated a wallet through either the `beldex-wallet-cli` or the desktop GUI wallet, and has enough Beldex to stake. They can then run the following command in their `beldex-wallet-cli` .

```
stake <Master Node Pubkey> <address> <contribution amount>
```

Where the `<Master Node Pubkey>` is the Pubkey provided from the Master Node operator, the `<address>` the service node operator will likely reserve an address for which they want you to stake for, this will usually be the same address as the wallet you are planning to stake from, in the case of an open pool this will always be the address you will you stake from and you will also receive rewards here too. `<contribution amount>` is the amount of Beldex they are going to stake which they agreed to with the Master Node Operator.

If using the desktop GUI wallet, the Stake command can be found under the Advanced - Master Node
menu.  Enter the service `<Master Node Pubkey>` and `<contribution amount>` and hit the Stake
button.

At this stage you will need to wait for the other contributors to provide their collateral. Once everyone has staked you can refer to **“Step 7 - Master Node Check”** to see where your Master Node Operator’s node is in the list.

Congratulations, you are now staking.

### Step 7 - Master Node Check

After we have locked our collateral we will need to check if our Master Node Pubkey is sitting in the list with the other Master Node’s on the network. This will prove our Master Node is running, recognised and will receive a reward if it keeps running.

Connect to the VPS where the service node is running and run the following command to see our Master Node Public Key:

```
~/beldex/beldexd print_mn_key
```

The Master Node Public Key is used to identify our Master Node within the list of Master Nodes currently on the network.

If you want more detailed Master Node status you can use the follow command:

```
~/beldex/beldexd print_mn_status
```


You can jump onto [http://explorer.beldexcoin.com/](http://explorer.beldexcoin.com/) to see if your Master Node is in the list or we can continue in the terminal to output the same information.

>If you are running your Master Node on testnet go to [http://testnetexplorer.beldexcoin.com/](http://testnetexplorer.beldexcoin.com/) instead.

To check this information directly with the service node itself, first get the current block height by running `~/beldex/beldexd status` into the terminal: it will output this information. Once we have the block height we can then check the current Master Nodes on the network at our specified block height.

Run the command `~/beldex/beldexd print_quorum_state <block height>` replacing `<block height>` with the number minus 1 that was outputted when running `status` command.

If your `<Master Node Pubkey>` is sitting in the list you know you are now staking.

### Step 8 - Unlock Stake

Master Nodes will continually receive block rewards indefinitely until a stake is unlocked or the Master Node becomes deregistered. Unlocking is available via the following command which needs to be run in the command line wallet:

```
request_stake_unlock <service node key>
``` 

Once the unlock is requested and the request is included in a block in the blockchain, the Master Node will then expire in 15 days (10800 blocks) and the funds will become unlocked after expiry.

In pooled nodes, any contributor that requests the stake to unlock will schedule the Master Node for expiration. All locked stakes in that Master Node will be unlocked in 15 days (10800 blocks). Once the unlock is requested, this process can not be undone or prolonged. Master Node participants will continue receiving rewards until expiration.

Deregistrations can be issued at any point during the active lifecycle of the Master Node. This is inclusive of the time period during which the Master Node is scheduled for expiry. Getting deregistered removes your Master Node from the network and your stakes are placed into a list of blacklisted transactions. Blacklisted transactions are locked and unspendable for 30 days (21600 blocks) from the block in which the Master Node was deregistered.

Receiving a deregistration after participants have already requested the stake to unlock overrides the 15 day (10800 blocks) unlock time, and resets the unlock time to 30 days (21600 blocks).

### Optional

#### See Locked Stake Amount and Duration

We can also view our locked stake by running the following command from our `beldex-wallet-cli` we staked from:
```
print_locked_stakes
```

## Express Setup Guide

This section is for power users who are more familiar with servers and the CLI interface. There's a couple of things your going to want to do before you commence.

**1. Get a Server that meets requirements**

**2. Run the Daemon on a server from a non-root user account, then stake from a local wallet (or a wallet on a separate server).**

> Where `<VERSION>` is mentioned replace with the [latest version](https://github.com/beldex-coin/beldex/releases/latest), example `v3.0.2`

**3. Connect via SSH to your server**

**4. add new user**
```
sudo adduser mnode
```

```
<enter>
```

```
Y
```

```
usermod -aG sudo mnode
```

```
exit
```

**5. login to your new user account via SSH** 

```
mnode@<ipaddress>
```

**6. Update necessary security patches and system utilities**

```
sudo apt update
```

```
sudo apt upgrade
```

**7. Download & unzip Beldex**

```
sudo apt install wget unzip
```

```
wget https://github.com/beldex-coin/beldex/releases/download/v<VERSION>/beldex-linux-x64-<VERSION>.zip
```

```
unzipbeldex-linux-x64-<VERSION>.zip
```

```
ln -snfbeldex-linux-x64-<VERSION>beldex
```

**8. Set up Beldex to run as a service**

```
sudo nano /etc/systemd/system/beldexd.service
```

Paste the following:
```
Description=beldexd service node
After=network-online.target

[Service]
Type=simple
User=mnode
ExecStart=/home/mnode/beldex/beldexd --non-interactive --service-node
Restart=always
RestartSec=30s

[Install]
WantedBy=multi-user.target
```

Save and exit:
`CTRL+X -> Y -> ENTER`

Enable and start the service:
```
sudo systemctl daemon-reload
sudo systemctl enablebeldexd.service
sudo systemctl startbeldexd.service
```

Wait for the Beldex Daemon sync the blockchain (1 - 8 Hours depending on internet speed).  You can
watch the progress using:

```
sudo journalctl -u beldexd.service -af
```

Hit `Ctrl-C` when you are tired of watching.

**9. Open a Wallet**

This wallet can be in a `screen` session on the Master Node machine, or a wallet on your local computer (assuming you have downloaded the binaries locally).

```
cdbeldex-linux-x64-<VERSION>
```

Linux/MAC - `./beldex-wallet-cli`
Windows - `beldex-wallet-cli`

Enter Name: Name your wallet

Enter password 

Language: `1` (for English)

Securely store:

1. Address

2. Seed Phrase 

3. Pass-phrase

Send enough Beldex to fund a node, wait for Balance to be unlocked (20 mins, 10 confirmations)

**10. Register your Master Node**

Connect via SSH to your VPS with the Master Node running (`mnode@<ipaddress>`).

```
~/beldex/beldexd prepare_registration
```

Contribute entire Stake: `Y/N`

Enter Beldex Address

Enable Restaking: `Y/N`

Confirm: `Y`

Copy green registration message

`Ctrl +AD`

**11. Reattach to Master Node or local wallet**

Paste in registration message `<enter>`

**12 Connect back to Master Node VPS account**

```
~/beldex/beldexd print_sn_key
```

Copy service node key, and search for it on:

[http://explorer.beldexcoin.com/master_nodes](http://explorer.beldexcoin.com/master_nodes).

or check the detailed status using:

```
~/beldex/beldexd print_sn_key
```

## Conclusion

Well done! You will receive a block reward when your Master Node has been active for some time and the network chooses you within the list.

**Bonus**: Use the community-run telegram bot `@BeldexSNBot` to receive on-the-fly updates about your service node. Props to @jagerman42 for building this.

**Bonus 2**: View https://imaginary.stream/sn/ for more details on Beldex Master Node staking requirements. 

This guide will be regularly updated when new features are added to Snodes. [Join the discord for more discussion.](https://discord.gg/FkwRPSA)

If you can improve this guide, please submit a pull request. 
