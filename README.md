# Timer Counter Plugin

A minimal Omarchy plugin that provides a timer/counter. It features a bar widget to summon a panel where you can set, start, stop, and reset countdowns.

## Installation

```bash
omarchy plugin add https://github.com/leofle/omarchy-plugin-test.git
omarchy-shell shell setPluginEnabled community.timer-counter true
omarchy bar put community.timer-counter --section right
```

## Features

- Timer icon in the bar.
- Countdown panel.
- Start/Stop/Reset functionality.
