# Homebrew Tap for Terraphim AI

This is the official [Homebrew](https://brew.sh/) tap for [Terraphim AI](https://github.com/terraphim/terraphim-ai) tools.

## Installation

```bash
# Add the tap
brew tap terraphim/terraphim

# Install tools
brew install terraphim-server   # HTTP API server
brew install terraphim-agent    # Interactive TUI/REPL
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `terraphim-server` | Privacy-first AI assistant HTTP server with semantic search |
| `terraphim-agent` | Interactive TUI and REPL for semantic knowledge graph search |

## Usage

### Terraphim Server

```bash
# Start the server
terraphim_server

# Run as a background service
brew services start terraphim-server

# Check status
brew services info terraphim-server
```

The server will be available at `http://localhost:8000`.

### Terraphim Agent (TUI)

```bash
# Start interactive REPL
terraphim-agent

# Available commands:
# /help           - Show all commands
# /search "query" - Semantic search
# /chat "message" - AI conversation
```

## Configuration

Configuration files are installed to:
- Server: `$(brew --prefix)/etc/terraphim/`

## Updating

```bash
brew update
brew upgrade terraphim-server terraphim-agent
```

## Building from HEAD

To install the latest development version:

```bash
brew install --HEAD terraphim-server
brew install --HEAD terraphim-agent
```

## Troubleshooting

### Build fails with OpenSSL errors

Ensure OpenSSL is properly linked:

```bash
brew reinstall openssl@3
export PKG_CONFIG_PATH="$(brew --prefix openssl@3)/lib/pkgconfig"
brew reinstall terraphim-server
```

### Gatekeeper blocks execution (unsigned binaries)

Current builds are unsigned. To allow execution:

```bash
# Right-click the app and select "Open", or:
xattr -d com.apple.quarantine $(which terraphim_server)
```

> Note: Signed and notarized binaries are coming soon!

## Links

- [Main Repository](https://github.com/terraphim/terraphim-ai)
- [Documentation](https://github.com/terraphim/terraphim-ai#readme)
- [Issues](https://github.com/terraphim/terraphim-ai/issues)

## License

Apache-2.0

