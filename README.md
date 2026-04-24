# TonSwift

A comprehensive Swift library for TON (The Open Network) blockchain interactions, providing wallet management, smart contract support, and TonConnect integration.

## Features

- **Wallet Management**: Key pair generation with BIP39 mnemonic support
- **Smart Contracts**: Wallet V4, Jetton, NFT contract support
- **Address Handling**: User-friendly and raw address formats
- **TonConnect**: DApp integration with TonConnect protocol
- **Token Support**: Jetton (fungible token) and NFT operations

## Requirements

- Swift 5.5+
- iOS 13.0+ / macOS 10.15+

## Installation

### Swift Package Manager

Add TonSwift to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/xueyuejie/TonSwift.git", from: "1.0.0")
]
```

## Usage

### Key Pair Generation

```swift
import TonSwift

// Generate key pair from mnemonic
let mnemonic = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about"
let keyPair = try TonKeypair(mnemonics: mnemonic)

// Access keys
print(keyPair.publicKey.hex)
print(keyPair.privateKey?.hex)
```

### Address Handling

```swift
import TonSwift

// Parse address from string
let address = Address(addressStr: "EQDi...")

// Address properties
print(address?.wc)           // Workchain (0 or -1)
print(address?.toHex())      // Hex representation
print(address?.toDecimal())  // Decimal representation

// Create user-friendly address
let friendly = address?.toString(
    isUserFriendly: true,
    isUrlSafe: true,
    isBounceable: false,
    isTestOnly: false
)

// Create raw address
let raw = address?.toString(isUserFriendly: false)
```

### Wallet Contract

```swift
import TonSwift

// Create wallet V4 contract
let options = Options(
    workchain: 0,
    publicKey: keyPair.publicKey,
    walletId: 698983191
)

let wallet = try WalletV4ContractR2(options: options)

// Get wallet address
let walletAddress = try wallet.getAddress()
print(walletAddress.toString())

// Create transfer message
let transfer = try wallet.createTransfer(
    seqno: 0,
    secretKey: keyPair.privateKey!,
    messages: [
        // Add transfer messages here
    ]
)
```

### TonWallet

```swift
import TonSwift

// Create wallet instance
let tonWallet = TonWallet(
    walletVersion: .V4R2,
    options: Options(publicKey: publicKey)
)

// Deploy wallet contract
let contract = try tonWallet.create()
```

### Jetton Operations

```swift
import TonSwift

// Create Jetton minter contract
let jettonMinter = JettonMinterContract(options: minterOptions)

// Create Jetton wallet contract
let jettonWallet = JettonWalletContract(options: walletOptions)

// Transfer jettons
let transfer = try jettonWallet.createTransfer(
    amount: 1000000,
    destination: receiverAddress,
    responseDestination: senderAddress
)
```

### NFT Operations

```swift
import TonSwift

// NFT utilities
let nftUtils = NftUtils()

// Transfer NFT
let nftTransfer = try nftUtils.createTransfer(
    nftAddress: nftAddress,
    destination: newOwnerAddress
)
```

### TonConnect Integration

```swift
import TonSwift

// Initialize TonConnect
let parameters = TonConnectParameters(
    clientId: "dapp_client_id",
    payload: TonConnectPayload(manifestUrl: "https://dapp.com/manifest.json")
)

let tonConnect = TonConnect(
    parameters: parameters,
    keyPair: keyPair,
    address: walletAddress
)

// Connect to dApp
tonConnect.connect { isConnect, result in
    if let result = result {
        // Handle connection result
        print("Connected: \(result)")
    }
}

// Listen for dApp requests
tonConnect.sse { result, error in
    if let request = result {
        // Handle dApp request
        // Types: SendTransaction, SignData, etc.
    }
}
```

### Wallet Versions

```swift
import TonSwift

// Supported wallet versions
public enum WalletVersion {
    case V4R2        // Wallet V4 R2 (recommended)
    case jettonWallet // Jetton wallet
}
```

### StateInit

```swift
import TonSwift

// Create StateInit for contract deployment
let stateInit = try createStateInit()

// Get address from StateInit
let contractAddress = stateInit.address
```

## Contract Types

| Type | Description |
|------|-------------|
| WalletV4ContractR2 | Latest wallet contract with plugin support |
| JettonMinterContract | Jetton token minter |
| JettonWalletContract | User's jetton wallet |
| ConnectContract | TonConnect session contract |

## TonConnect Messages

```swift
import TonSwift

// TonConnect request types
// - SendTransaction
// - SignData
// - Disconnect
```

## Dependencies

- **TweetNacl**: Ed25519 cryptographic signatures
- **BIP39swift**: Mnemonic code generation
- **PromiseKit**: Promise-based async operations
- **BigInt**: Arbitrary precision integers
- **AnyCodable**: Dynamic JSON handling
- **Alamofire**: HTTP networking

## Contract Deployment

```swift
import TonSwift

// Create deploy message
let deployMessage = try wallet.createDeployMessage(
    seqno: 0,
    secretKey: keyPair.privateKey!
)

// Serialize for sending
let serialized = try deployMessage.serialize()
```

## License

MIT License
