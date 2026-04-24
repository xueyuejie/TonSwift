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

---

# TonSwift 中文文档

一个全面的 TON（The Open Network）区块链交互 Swift 库，提供钱包管理、智能合约支持和 TonConnect 集成功能。

## 功能特性

- **钱包管理**：支持 BIP39 助记词的密钥对生成
- **智能合约**：支持 Wallet V4、Jetton、NFT 合约
- **地址处理**：用户友好和原始地址格式
- **TonConnect**：DApp 集成 TonConnect 协议
- **代币支持**：Jetton（同质化代币）和 NFT 操作

## 系统要求

- Swift 5.5+
- iOS 13.0+ / macOS 10.15+

## 安装方式

### Swift Package Manager

在 `Package.swift` 中添加依赖：

```swift
dependencies: [
    .package(url: "https://github.com/xueyuejie/TonSwift.git", from: "1.0.0")
]
```

## 使用示例

### 密钥对生成

```swift
import TonSwift

// 从助记词生成密钥对
let mnemonic = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about"
let keyPair = try TonKeypair(mnemonics: mnemonic)

// 访问密钥
print(keyPair.publicKey.hex)
print(keyPair.privateKey?.hex)
```

### 地址处理

```swift
import TonSwift

// 从字符串解析地址
let address = Address(addressStr: "EQDi...")

// 地址属性
print(address?.wc)           // 工作链（0 或 -1）
print(address?.toHex())      // 十六进制表示
print(address?.toDecimal())  // 十进制表示

// 创建用户友好地址
let friendly = address?.toString(
    isUserFriendly: true,
    isUrlSafe: true,
    isBounceable: false,
    isTestOnly: false
)

// 创建原始地址
let raw = address?.toString(isUserFriendly: false)
```

### 钱包合约

```swift
import TonSwift

// 创建 Wallet V4 合约
let options = Options(
    workchain: 0,
    publicKey: keyPair.publicKey,
    walletId: 698983191
)

let wallet = try WalletV4ContractR2(options: options)

// 获取钱包地址
let walletAddress = try wallet.getAddress()
print(walletAddress.toString())

// 创建转账消息
let transfer = try wallet.createTransfer(
    seqno: 0,
    secretKey: keyPair.privateKey!,
    messages: [
        // 在此添加转账消息
    ]
)
```

### TonWallet

```swift
import TonSwift

// 创建钱包实例
let tonWallet = TonWallet(
    walletVersion: .V4R2,
    options: Options(publicKey: publicKey)
)

// 部署钱包合约
let contract = try tonWallet.create()
```

### Jetton 操作

```swift
import TonSwift

// 创建 Jetton 铸币合约
let jettonMinter = JettonMinterContract(options: minterOptions)

// 创建 Jetton 钱包合约
let jettonWallet = JettonWalletContract(options: walletOptions)

// 转账 Jetton
let transfer = try jettonWallet.createTransfer(
    amount: 1000000,
    destination: receiverAddress,
    responseDestination: senderAddress
)
```

### NFT 操作

```swift
import TonSwift

// NFT 工具类
let nftUtils = NftUtils()

// 转移 NFT
let nftTransfer = try nftUtils.createTransfer(
    nftAddress: nftAddress,
    destination: newOwnerAddress
)
```

### TonConnect 集成

```swift
import TonSwift

// 初始化 TonConnect
let parameters = TonConnectParameters(
    clientId: "dapp_client_id",
    payload: TonConnectPayload(manifestUrl: "https://dapp.com/manifest.json")
)

let tonConnect = TonConnect(
    parameters: parameters,
    keyPair: keyPair,
    address: walletAddress
)

// 连接到 DApp
tonConnect.connect { isConnect, result in
    if let result = result {
        // 处理连接结果
        print("已连接: \(result)")
    }
}

// 监听 DApp 请求
tonConnect.sse { result, error in
    if let request = result {
        // 处理 DApp 请求
        // 类型：SendTransaction、SignData 等
    }
}
```

### 钱包版本

```swift
import TonSwift

// 支持的钱包版本
public enum WalletVersion {
    case V4R2        // Wallet V4 R2（推荐）
    case jettonWallet // Jetton 钱包
}
```

### StateInit

```swift
import TonSwift

// 创建用于合约部署的 StateInit
let stateInit = try createStateInit()

// 从 StateInit 获取地址
let contractAddress = stateInit.address
```

## 合约类型

| 类型 | 描述 |
|------|------|
| WalletV4ContractR2 | 最新钱包合约，支持插件 |
| JettonMinterContract | Jetton 代币铸币合约 |
| JettonWalletContract | 用户的 Jetton 钱包 |
| ConnectContract | TonConnect 会话合约 |

## TonConnect 消息

```swift
import TonSwift

// TonConnect 请求类型
// - SendTransaction（发送交易）
// - SignData（签名数据）
// - Disconnect（断开连接）
```

## 依赖库

- **TweetNacl**: Ed25519 密码学签名
- **BIP39swift**: 助记词生成
- **PromiseKit**: 基于 Promise 的异步操作
- **BigInt**: 任意精度整数
- **AnyCodable**: 动态 JSON 处理
- **Alamofire**: HTTP 网络请求

## 合约部署

```swift
import TonSwift

// 创建部署消息
let deployMessage = try wallet.createDeployMessage(
    seqno: 0,
    secretKey: keyPair.privateKey!
)

// 序列化以便发送
let serialized = try deployMessage.serialize()
```

## 许可证

MIT License
