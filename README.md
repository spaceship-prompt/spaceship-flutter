<h1 align="center">
  💙 + 🚀
  <br>Spaceship Flutter<br>
</h1>

<h4 align="center">
  A <a href="https://flutter.dev" target="_blank">Flutter</a> section for Spaceship prompt
</h4>

<p align="center">
  <a href="https://github.com/spaceship-prompt/spaceship-flutter/releases">
    <img src="https://img.shields.io/github/v/release/spaceship-prompt/spaceship-flutter.svg?style=flat-square"
      alt="GitHub Release" />
  </a>

  <a href="https://github.com/spaceship-prompt/spaceship-flutter/actions">
    <img src="https://img.shields.io/github/workflow/status/spaceship-prompt/spaceship-flutter/ci?style=flat-square"
      alt="GitHub Workflow Status" />
  </a>

  <a href="https://twitter.com/SpaceshipPrompt">
    <img src="https://img.shields.io/badge/twitter-%40SpaceshipPrompt-00ACEE.svg?style=flat-square"
      alt="Spaceship Twitter" />
  </a>

  <a href="https://discord.gg/NTQWz8Dyt9">
    <img
      src="https://img.shields.io/discord/859409950999707668?label=discord&logoColor=white&style=flat-square"
      alt="Chat on Discord"
    />
  </a>
</p>

Current Flutter version, through flutter (`💙`).

## Installing

You need to source this plugin somewhere in your dotfiles. Here's how to do it with some popular tools:

### [Oh-My-Zsh]

Execute this command to clone this repo into Oh-My-Zsh plugin's folder:

```zsh
git clone https://github.com/spaceship-prompt/spaceship-flutter.git $ZSH_CUSTOM/plugins/spaceship-flutter
```

Include `spaceship-flutter` in Oh-My-Zsh plugins list:

```zsh
plugins=($plugins spaceship-flutter)
```

### [zplug]

```zsh
zplug "spaceship-prompt/spaceship-flutter"
```

### [antigen]

```zsh
antigen bundle "spaceship-prompt/spaceship-flutter@main"
```

### [antibody]

```zsh
antibody bundle "spaceship-prompt/spaceship-flutter"
```

### [zinit]

```zsh
zinit light "spaceship-prompt/spaceship-flutter"
```

### [zgen]

```zsh
zgen load "spaceship-prompt/spaceship-flutter"
```

### [sheldon]
**Important!!** Make sure the flutter section is loaded before `spaceship-prompt` itself, see below.   
Add the plugin with the Sheldon command
```
sheldon add spaceship-flutter --github spaceship-prompt/spaceship-flutter
```
or edit your `plugins.toml` file directly with `sheldon edit`.
```toml
[plugins]

[plugins.spaceship-flutter]
github = 'spaceship-prompt/spaceship-flutter'

[plugins.spaceship]
github = 'spaceship-prompt/spaceship-prompt'
```

### Manual

If none of the above methods works for you, you can install Spaceship manually.

1. Clone this repo somewhere, for example to `$HOME/.zsh/spaceship-flutter`.
2. Source this section in your `~/.zshrc`.

### Example

```zsh
mkdir -p "$HOME/.zsh"
git clone --depth=1 https://github.com/spaceship-prompt/spaceship-flutter.git "$HOME/.zsh/spaceship-flutter"
```

For initializing prompt system add this to your `.zshrc`:

```zsh title=".zshrc"
source "~/.zsh/spaceship-flutter/spaceship-flutter.plugin.zsh"
```

## Usage

After installing, add the following line to your `.zshrc` in order to include Flutter section in the prompt:

```zsh
spaceship add flutter
```

## Options

The `flutter` section displays the current version and channel of Flutter.

This section is displayed only when the current directory is within a [Dart](https://dart.dev/) project
with [Flutter](https://flutter.dev/) dependency.

| Variable                           | Default                             | Meaning                             |
| :--------------------------------- | :--------------------------------:  | ----------------------------------- |
| `SPACESHIP_FLUTTER_SHOW`           | `true`                              | Show section                        |
| `SPACESHIP_FLUTTER_ASYNC`          | `true`                              | Render section asynchronously       |
| `SPACESHIP_FLUTTER_PREFIX`         | `$SPACESHIP_PROMPT_DEFAULT_PREFIX`  | Section's prefix                    |
| `SPACESHIP_FLUTTER_SUFFIX`         | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX`  | Section's suffix                    |
| `SPACESHIP_FLUTTER_SYMBOL`         | `💙·`                               | Symbol displayed before the section |
| `SPACESHIP_FLUTTER_COLOR`          | `blue`                              | Section's color                     |
| `SPACESHIP_FLUTTER_CHANNEL_SHOW`   | `true`                              | Show channel                        |
| `SPACESHIP_FLUTTER_CHANNEL_PREFIX` | ``                                  | Channel's prefix                    |
| `SPACESHIP_FLUTTER_CHANNEL_SUFFIX` | ``                                  | Channel's suffix                    |
| `SPACESHIP_FLUTTER_CHANNEL_SYMBOL` | `.#`                                | Symbol displayed before the channel |


## License

MIT © [Peter Merikan](http://merikan.com) and [Denys Dovhan](http://denysdovhan.com)

<!-- References -->

[Oh-My-Zsh]: https://ohmyz.sh/
[zplug]: https://github.com/zplug/zplug
[antigen]: https://antigen.sharats.me/
[antibody]: https://getantibody.github.io/
[zinit]: https://github.com/zdharma/zinit
[zgen]: https://github.com/tarjoilija/zgen
[sheldon]: https://sheldon.cli.rs/
