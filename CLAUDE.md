# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single static page, `tennis-site.html`: a Hebrew (RTL) promotional site for a tennis champion who won Wimbledon and Roland Garros in 2026 and was a former rival of Andre Agassi. It is published as a claude.ai Artifact at https://claude.ai/artifact/XTwtSzHjh3tDwxd4kF48Sd.

There is no build system, package manager, linter or test suite. It is not a git repository.

## Publishing

- The file is an Artifact page fragment, not a full HTML document. It has no `<!doctype>`, `<html>`, `<head>` or `<body>` tags, because the Artifact publisher wraps it in that skeleton. Keep it that way.
- To update the live page, republish the same file path (`/home/user/tennis-site.html`) with the Artifact tool. A different path creates a new URL. Don't pass `icon` on a redeploy. For small changes, pass `edits` on the publish call, which updates the file and the live page together.
- Only these external hosts load: Google Fonts (stylesheets/fonts), and scripts from cdnjs/jsDelivr/unpkg. Images must be inline (`data:` URIs). `mailto:`/`tel:` links are unreliable, so contact details are shown as plain text.

## Structure and conventions

- All content sits inside one `<div dir="rtl" lang="he">` wrapper. Scores and emails use `dir="ltr"`.
- Styling is a single inline `<style>` block driven by CSS tokens on `:root`: grass/clay/ball colors plus the `--display` (Secular One) and `--body` (Assistant) fonts. Dark mode redefines the same tokens twice: under `@media (prefers-color-scheme: dark)` guarded by `:root:not([data-theme="light"])`, and under `:root[data-theme="dark"]`. Add new colors as tokens in all three blocks. Don't put literal colors in components.
- Side gutters use `padding-left/right: max(16px, env(safe-area-inset-*))` on `.wrap`. This is paired with the `claude:viewport-fit-sides` meta tag at the top of the file.
- The hero's decorations are all drawn in code, since external images are blocked. There are 7 `.hero-ball` divs (sizes and motion set by the `.b2`–`.b7` modifiers), an SVG `.crowd` strip filled from the `#fans` pattern, and two inline-SVG `.player` figures. `.p2` is the same drawing mirrored with `scaleX(-1)`, and the racket arm (`.swing`) rotates around the shoulder at 58,38 in the viewBox. Every animation is turned off under `prefers-reduced-motion`. On phones the players shrink and fade so they don't cover the name.
- Sections are the hero (split grass and clay court), the stats strip, `#titles`, `#rival` (head-to-head record), the quote, `#career` (timeline) and `#contact`. The nav links point at those ids.
- The contact form only shows a confirmation message (`preventDefault`). Nothing is submitted anywhere.

## Placeholder content

The player's name (אריאל שגב) and every statistic, score, date, quote and contact detail are invented placeholders. Replace them with real details from the user before treating the page as final, and keep the head-to-head bar width (`.bar i` width %) in sync with the record.
