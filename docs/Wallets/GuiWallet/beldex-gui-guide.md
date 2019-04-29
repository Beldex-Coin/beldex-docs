#Setup Guide on the Beldex GUI Wallet

This document will tell you exactly how to set up and operate the Beldex GUI wallet.
The latest version of the wallet can be downloaded [here](https://github.com/beldex-coin/beldex-gui/releases).

**Windows users:** (**Mac and Linux users skip to step 6**)

1) Make sure Windows Defender (or other anti-virus software) is not flagging it. Add 'beldex-gui-win...'  folder (or saved name of download) to exclusions in Windows Defender.

<center>![windows-defender-guide1](../../assets/images/AV1.PNG)</center>

<center>![windows-defender-guide2](../../assets/images/AV2.PNG)</center>

<center>![windows-defender-guide3](../../assets/images/AV3.PNG)</center>

2) After exclusion is added, check if `beldexd.exe` is still in the folder. If it's not, unzip the archive file once again and put the files in the previously created folder.

<center>![beldexd-exe](../../assets/images/beldexd.PNG)</center>


3) Make sure that the path to your Beldex folder doesn't contain non-latin characters.  

4) Right click `beldex-wallet-gui.exe` and select 'run as administrator'.

<center>![beldex-wallet-gui](../../assets/images/beldex-wallet-gui.PNG)</center>
  
5) If it crashes after the steps above are performed, run the file named `start-low-graphics-mode.bat` in the Beldex folder.

<center>![low-graphics-mode](../../assets/images/low_graphics_mode.png)</center>

6) Select your language.

<center>![language-select](../../assets/images/language-select.PNG)</center>

7) Select 'create a new wallet'.

<center>![create-new-wallet](../../assets/images/create-new-wallet.PNG)</center>

8) **This step is important! Please be careful to write down and save your seed exactly as you see it on the screen and store it in a safe location.**

<center>![wallet-seed](../../assets/images/wallet-setup-seed.PNG)</center>

9) Enter a strong password.

<center>![enter-pass](../../assets/images/enter-pass.PNG)</center>


10) If you have problems with syncing or connecting to the daemon, try to connect to a remote node (recommended):

Go to settings > go to node > select a remote node and click 'load preset' > scroll down and click 'connect'.

<center>![remote-node-pic](../../assets/images/remote_node.PNG)</center>
