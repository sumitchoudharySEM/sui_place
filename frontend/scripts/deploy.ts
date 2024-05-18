import "dotenv/config"
import { Ed25519Keypair } from "@mysten/sui.js/keypairs/ed25519"
import {fromB64} from "@mysten/sui.js/utils"
import {SuiClient} from "@mysten/sui.js/client"
import {fileURLToPath} from "url"

import path, {dirname} from "path"
import {execSync} from "child_process"

let priv_key = process.env.PRIVATE_KEY;

if (!priv_key) {
    console.error("Please provide a private key in the .env file");
}
console.log(priv_key)

const keypair = Ed25519Keypair.fromSecretKey(fromB64(priv_key).slice(1))
const client = new SuiClient({url:"https://fullnode.devnet.sui.io:443"})

const path_to_contract = path.join(dirname(fileURLToPath(import.meta.url)), "../../contracts/sources/place.move")
console.log(path_to_contract)
// console.log(JSON.parse(execSync(
//     `sui move build --dump-bytecode-as-base64 --path ${path_to_contract}`
// )))
try {
    const output = execSync(
      `sui move build --dump-bytecode-as-base64 --path "${path_to_contract}"`,
      {encription: "utf-8"}  // Capture both stdout and stderr
    );
  
    console.log('Output:', output.toString());
  } catch (error) {
    console.error('Error aa gya:', error.stderr.toString());
  }


