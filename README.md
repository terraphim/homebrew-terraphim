# Homebrew Tap for Terraphim AI

This is the official [Homebrew](https://brew.sh/) tap for Terraphim tools.

## Installation

```bash
# Add the tap
brew tap terraphim/terraphim

# Install tools
brew install terraphim-server   # HTTP API server
brew install terraphim-agent    # Agent memory, learning, and session commands
brew install terraphim-grep     # Local code and documentation search
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `terraphim-server` | Privacy-first AI assistant HTTP server with semantic search |
| `terraphim-agent` | Agent memory, learning, session, and knowledge graph workflows |
| `terraphim-grep` | Local text and knowledge-graph-assisted search |

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

### Terraphim Agent

```bash
# Inspect the installed command surface
terraphim-agent --help
terraphim-agent learn --help
terraphim-agent memory --help

# Search local code and documentation
terraphim-grep --help
```

## Configuration

Configuration files are installed to:
- Server: `$(brew --prefix)/etc/terraphim/`

## Updating

```bash
brew update
brew upgrade terraphim-server terraphim-agent terraphim-grep
```

## Troubleshooting

### Build fails with OpenSSL errors

Ensure OpenSSL is properly linked:

```bash
brew reinstall openssl@3
export PKG_CONFIG_PATH="$(brew --prefix openssl@3)/lib/pkgconfig"
brew reinstall terraphim-server
```

### Verify downloaded binaries

The macOS `terraphim-agent` and `terraphim-grep` binaries are signed with the
Terraphim Developer ID. Homebrew also verifies the SHA-256 checksum before
installation. Check the installed signatures with:

```bash
codesign --verify --verbose=2 "$(which terraphim-agent)"
codesign --verify --verbose=2 "$(which terraphim-grep)"
```

## Links

- [Client Repository](https://github.com/terraphim/terraphim-clients)
- [Terraphim Skills](https://terraphim-skills.md/skills/)
- [Issues](https://github.com/terraphim/terraphim-clients/issues)

## License

Apache-2.0
