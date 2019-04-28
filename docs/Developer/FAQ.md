# FAQ
## Hardfork Version 10: Bulletproofs
### `get_block_template` Updates
Due to batching of Governance rewards the calculation of rewards has been updated in Beldex. As a side effect of this, in the `get_block_template` json response, `expected_reward` now returns only the miner reward instead of the entire block reward.

For example, pre-hardfork 9, if the block reward was 100, `expected_reward` returned 100, even though ~50% of the reward was sent to the master node. Post Bulletproofs hardfork, `expected_reward` now returns 50, which is the exact amount the miner would receive.

A real example of this is on the testnet, for block 63056.

Calling `get_block_template` on block 63056
```
curl -X POST http://127.0.0.1:38157/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_block_template","params":{"wallet_address":"86TBLkrPd7KQubsczrfHCEi5T4prNEH5Sax9phVicLp9H5s2xAvnJaYWs26xL2s2wy838FXdmgds2TDX5f75wnLt1Zxmiq3rm","reserve_size":60}' -H 'Content-Type: application/json'
{
  "id": "0",
  "jsonrpc": "2.0",
  "result": {
    "blockhashing_blob": "0a0ad9e3c6e0050e34f22aeb5fc6ef48e99f9b7e87f3c72666a944c0e5e8c13659e09c934708dd00000000add4d0b6d74e9d17d4e65a64e2f6f47959a3fa60cd92af0f9ac0a771a31920ec01",
    "blocktemplate_blob": "0a0ad9e3c6e0050e34f22aeb5fc6ef48e99f9b7e87f3c72666a944c0e5e8c13659e09c934708dd000000000302eeec03eeec0300eeec0301ffd0ec0302fea381ab840102eea98077132617bdf7c78c211674e704a73a82b5e6fb2361e9f08c20403b301dd2d28f85930102cee0e4e9534167d66200577aa84b73c318ea494538b1a0af5521e90500835651a101019a58d937a55a6a7b6df6c42aba6d6790be8f5b1b2bfecdb8658ba0836e285912023c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101dda172e3c0d0da4381557e1d65319d0cfb0da9f6d83b716de5b8e127ddd7f572fcb147715be4f8f3cd5d25aae839e217bda00bb7bb02c21b00cdd5a18cd38aba0000",
    "difficulty": 11367,
    "expected_reward": 35523678718,
    "height": 63056,
    "prev_hash": "0e34f22aeb5fc6ef48e99f9b7e87f3c72666a944c0e5e8c13659e09c934708dd",
    "reserved_offset": 176,
    "status": "OK",
    "untrusted": false
  }
}
```

Calling `get_block` on block 63056
```
{
  "id": "0",
  "jsonrpc": "2.0",
  "result": {
    "blob": "0a0ae7e3c6e0050e34f22aeb5fc6ef48e99f9b7e87f3c72666a944c0e5e8c13659e09c934708ddd43bd8000302eeec03eeec0300eeec0301ffd0ec0302fea381ab840102ee55cf39cb6f15d22454101cccf6b7d41f1fdb5588e463404eca4b56cbd5bbc3d2d28f85930102cee0e4e9534167d66200577aa84b73c318ea494538b1a0af5521e9050083565163014e8a0d6c156a927b0f10a790d4cacede2cb2cd3b6f3fc3ed98664c303c08b97b0101dda172e3c0d0da4381557e1d65319d0cfb0da9f6d83b716de5b8e127ddd7f572fcb147715be4f8f3cd5d25aae839e217bda00bb7bb02c21b00cdd5a18cd38aba0000",
    "block_header": {
      "block_size": 197,
      "block_weight": 197,
      "cumulative_difficulty": 607871777,
      "depth": 1,
      "difficulty": 11367,
      "hash": "737da055d2fb78f07200a7f3ee0acbf9b00ec3536ab27920a656dd75a253fab6",
      "height": 63056,
      "major_version": 10,
      "minor_version": 10,
      "nonce": 14171092,
      "num_txes": 0,
      "orphan_status": false,
      "pow_hash": "",
      "prev_hash": "0e34f22aeb5fc6ef48e99f9b7e87f3c72666a944c0e5e8c13659e09c934708dd",
      "reward": 74994432848,
      "timestamp": 1544663527
    },
    "json": {
      "major_version": 10,
      "minor_version": 10,
      "timestamp": 1544663527,
      "prev_id": "0e34f22aeb5fc6ef48e99f9b7e87f3c72666a944c0e5e8c13659e09c934708dd",
      "nonce": 14171092,
      "miner_tx": {
        "version": 3,
        "output_unlock_times": [ 63086, 63086 ],
        "is_deregister": "00",
        "unlock_time": 63086,
        "vin": [ { "gen": { "height": 63056 } } ],
        "vout": [
          {
            "amount": 35523678718,
            "target": { "key": "ee55cf39cb6f15d22454101cccf6b7d41f1fdb5588e463404eca4b56cbd5bbc3" }
          },
          {
            "amount": 39470754130,
            "target": { "key": "cee0e4e9534167d66200577aa84b73c318ea494538b1a0af5521e90500835651" }
          }
        ],
        "extra": [ 1, 78, 138, 13, 108, 21, 106, 146, 123, 15, 16, 167, 144, 212, 202, 206, 222, 44,
          178, 205, 59, 111, 63, 195, 237, 152, 102, 76, 48, 60, 8, 185, 123, 1, 1, 221, 161, 114,
          227, 192, 208, 218, 67, 129, 85, 126, 29, 101, 49, 157, 12, 251, 13, 169, 246, 216, 59,
          113, 109, 229, 184, 225, 39, 221, 215, 245, 114, 252, 177, 71, 113, 91, 228, 248, 243,
          205, 93, 37, 170, 232, 57, 226, 23, 189, 160, 11, 183, 187, 2, 194, 27, 0, 205, 213, 161,
          140, 211, 138, 186 ],
        "rct_signatures": { "type": 0 }
      },
      "tx_hashes": []
    },
    "miner_tx_hash": "6993f786d3bcf50a2ae242d245b4de519c38903c062d59f8a30ed2af1f80934b",
    "status": "OK",
    "untrusted": false
  }
}
```

Of importance, from `get_block_template`
```
  ...
  "expected_reward": 35523678718,
  ...
```

And `get_block`
```
  ...
  "vout": [
    {
      "amount": 35523678718,
      "target": { "key": "ee55cf39cb6f15d22454101cccf6b7d41f1fdb5588e463404eca4b56cbd5bbc3" }
    },
    {
      "amount": 39470754130,
      "target": { "key": "cee0e4e9534167d66200577aa84b73c318ea494538b1a0af5521e90500835651" }
    }
  ],
  ...
```

The `expected_reward` is the same amount as the 1st vout amount in `get_block` which is the miner output (the 2nd being the Master Node Output). In summary, the `expected_reward` returned by `get_block_template` is exactly the reward the miner will receive.

### Extracting Reward Amounts from Block Outputs
In the Bulletproofs hardfork, batching of Governance rewards was introduced and removes the governance output from most miner transactions. This means, for most blocks the outputs will only include the Miner reward and the Master Node reward.

The Governance reward is paid out every `GOVERNANCE_REWARD_INTERVAL` number of blocks, in code this is checked as `(block_height % GOVERNANCE_REWARD_INTERVAL == 0)`.

```
Block Outputs
[  0] Miner Reward
[ ..] Master Node Reward
[  N]
[N+1] Governance Reward (Appears every GOVERNANCE_REWARD_INTERVAL blocks)
```

An example miner transaction JSON output with the Governance reward

```json
{
  "version": 3,
  "output_unlock_times": [ 49030, 49030, 49030, 49030, 49030 ],
  "is_deregister": "00",
  "unlock_time": 49030,
  "vin": [ { "gen": { "height": 49000 } } ],
  "vout": [ {
      "amount": 39242919169,
      "target": { "key": "1b318acc5674f71997c69710e2de96baa4d1776f19e5938381fa6f12d2d80eb8" }
    }, {
      "amount": 22237654195,
      "target": { "key": "4bb2511f0e46de56b07dfec51499feb027cb2f8ea6eff4ed93b176ef0d3de534" }
    }, {
      "amount": 10682794662,
      "target": { "key": "77446399029849e67ebd1df7728241920b7fa16c48c7794bf9dc15605b5d35f9" }
    }, {
      "amount": 10682794662,
      "target": { "key": "0fe5af8f07c09f07291d7e9b13ec45f35d2535a04e1ca710a1acad4c6f1a6665" }
    }, {
      "amount": 4376229747993,
      "target": { "key": "f1a6a802c4708a1c6eb083078290087d3974ce6ea72251821cd47c64325cf98f" }
    }
  ],
  "extra": [ 1, 51, 91, 83, 33, 151, 51, 186, 159, 157, 22, 207, 125, 106, 249, 180, 78, 209, 115, 87, 137, 148, 111, 194, 29, 183, 127, 195, 221, 207, 112, 147, 96, 1, 15, 153, 186, 200, 221, 217, 236, 119, 34, 82, 16, 3, 88, 68, 231, 87, 37, 85, 215, 211, 227, 140, 211, 75, 139, 67, 116, 190, 86, 79, 78, 243, 114, 163, 227, 143, 84, 151, 173, 48, 235, 64, 252, 86, 154, 104, 127, 82, 18, 101, 176, 99, 196, 186, 255, 191, 85, 34, 135, 248, 100, 29, 238, 82, 80 ],
  "rct_signatures": { "type": 0 }
}
```

An example miner transaction JSON output without the Governance reward

```json
{
  "version": 3,
  "output_unlock_times": [ 49029, 49029 ],
  "is_deregister": "00",
  "unlock_time": 49029,
  "vin": [ { "gen": { "height": 48999 } } ],
  "vout": [ {
      "amount": 39243204162,
      "target": { "key": "f57b08e200dc36a27b4cfe7ad4276103951c832153a46e3ba0fa613493dcd989" }
    }, {
      "amount": 43603560179,
      "target": { "key": "6d5e496c1171ca87345f43203ca14bbd09928368322372b621c9d56ee5c04816" }
    }
  ],
  "extra": [ 1, 111, 176, 48, 118, 238, 20, 185, 147, 73, 50, 237, 56, 244, 35, 100, 209, 18, 212, 20, 86, 198, 62, 67, 138, 81, 80, 191, 70, 208, 1, 245, 91, 1, 11, 40, 147, 97, 124, 226, 43, 104, 88, 49, 95, 19, 238, 240, 167, 62, 187, 128, 112, 79, 25, 145, 98, 176, 162, 207, 79, 7, 2, 59, 216, 8, 114, 86, 239, 115, 20, 49, 190, 232, 248, 253, 178, 163, 240, 56, 147, 237, 152, 185, 252, 116, 154, 225, 95, 58, 159, 122, 64, 249, 51, 183, 239, 255, 227 ],
  "rct_signatures": { "type": 0 }
}
```

## Hardfork Version 9: Master Nodes
### Extracting Reward Amounts from Block Outputs
This hardfork introduces Master Node rewards to the outputs of the miner transaction. Master Nodes can split the given reward with up to 4 participants. Then, at most the miner transaction can have a maximum of 6 outputs, 1 reserved for the miner, 1 for governance, up to 4 for master node participants.

```
Transaction Outputs
[  0] Miner Reward
[ ..] Master Node Reward
[  N]
[N+1] Governance Reward
```

An example miner transaction JSON output with 4 master node participants looks like

```json
{
  "version": 3,
  "output_unlock_times": [ 155552, 155552, 155552, 155552, 155552, 155552 ],
  "is_deregister": "00",
  "unlock_time": 155552,
  "vin": [ { "gen": { "height": 155522 } } ],
  "vout": [ {
      "amount": 21165158143,
      "target": { "key": "8e0870425ad7f7709d6a4125a7088f0dd284e5b0415248b4b8556678ad4f3a3d" }
    }, {
      "amount": 6221340556,
      "target": { "key": "03491d83a076a74df6c6d726aeffd2cc4c59ae56107c730a195ee329d838e088" }
    }, {
      "amount": 6607995571,
      "target": { "key": "a54619d6b0b68c8d824445336d5dd246338aa7482546118f48d32f5d92a3aad8" }
    }, {
      "amount": 6874654507,
      "target": { "key": "3941327ebcb42c3fa78fa450e0d7d1cf40b501832f0b4d9cc7a4654b4c1f685b" }
    }, {
      "amount": 3769035241,
      "target": { "key": "a8184d530cb7180590c04a19c38ba52c055d6ffcdfdad2fb62b8802477f11117" }
    }, {
      "amount": 2347302587,
      "target": { "key": "554f16bd4a06364b27edf898b5358b4e3f5c1218f3dc415d48eb2bff4707cf42" }
    }
  ],
  "extra": [ 1, 183, 139, 12, 51, 196, 162, 46, 137, 28, 148, 226, 122, 234, 40, 128, 33, 255, 251, 170, 208, 13, 80, 26, 17, 125, 130, 59, 48, 77, 47, 141, 124, 2, 48, 57, 48, 48, 49, 0, 5, 0, 0, 0, 35, 179, 201, 210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 175, 103, 128, 158, 243, 146, 164, 73, 129, 26, 30, 121, 232, 11, 191, 215, 180, 172, 163, 109, 3, 24, 155, 215, 12, 91, 205, 228, 207, 230, 98, 195, 114, 42, 113, 8, 57, 98, 253, 18, 228, 209, 176, 148, 179, 127, 111, 216, 201, 220, 3, 125, 188, 119, 29, 34, 140, 51, 224, 211, 10, 53, 119, 58, 1 ],
  "rct_signatures": { "type": 0 }
}
```
