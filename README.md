# Compatible Icons 🔥

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)  
[![GitHub stars](https://img.shields.io/github/stars/georgegach/compatible-icons?style=social)](https://github.com/georgegach/compatible-icons/stargazers)

Drop-in replacement for icon packs that lack available image formats. Compatible Icons generates multi-size, multi-color PNGs from source SVG sets for tools and markups that only support bitmap assets.

---
## 🚀 Start here!

- [simple-icons](simple-icons/README.md)


## 📁 Project Structure

```plaintext
README.md                    # <<< You are here
...
simple-icons/                # Subproject root (git clone .../simple-icons)
├─ scripts/                  # Collection of bash scripts
├─ icons/                    # SVG source files
├─ compat/                   # Generated PNGs & READMEs
│   ├─ <icon-name>/
│   │   ├─ 16/…              # 16px variants
│   │   │   ├─ black.png        # 16px black variant
│   │   │   ├─ slate.png        # 16px slate variant
│   │   │   ├─ white.png        # 16px white variant
│   │   │   └─ README.md        # Icon-specific README with previews, URLs, Base64, backlink
│   │   ├─ 64/…              # 64px variants
│   │   ├─ 128/…             # 128px variants
│   │   ├─ 512/…             # 512px variants
│   │   ├─ 1024/…            # 1024px variants
│   │   └─ README.md         # Icon-specific README with previews, URLs, Base64, backlink
│   └─ …
└─ README.md                 # Master README for Simple-Icons icon pack
```

**Scripts & Pages**
- `converter.sh`: converts SVGs via `rsvg-convert`, injects CSS, generates READMEs.
- `links.sh`: generates links for each icon in the master README.
- Jekyll-based GitHub Pages site with browsable README.md tree.
---

## ✨ Features

- **Bitmap outputs**: perfect for DSLs, PlantUML, and environments lacking SVG support
- **Multi-size**: 16, 64, 128, 512, 1024 px
- **Multi-color**: `white`, `black`, `slate`
- **Transparent background** for any theme
- **Per-icon and master READMEs** with previews, links, Base64 embeds, and navigation

---
## 📜 License

Released under the [MIT License](LICENSE).
