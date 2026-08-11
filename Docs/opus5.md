# Trance — Development Estimation (Solo Dev, Full-Time)

_Prepared from the design doc + a read of the current POC source. All figures are for **one developer at 40 h/week**. Weeks convert at ~4.3 working weeks / month._

---

## 1. How to read this

The estimate is built as a formula so it scales with how big a "set" you ship:

```
Total = Common (one-time shell + systems)
      + (complex tracks × per-complex cost)
      + (simple tracks  × per-simple cost)
      - Chakra credit (already ~half-built in the POC)
      + optional add-ons
```

Then I apply a realistic contingency buffer (solo projects overrun — this is not padding, it's the base rate).

### Assumptions (from your answers + the doc)

- **Art & audio are commissioned / outsourced.** So the time below is *your* hands-on time: programming, design, level assembly, and the spec-writing / art-direction / integration overhead of running an external pipeline. It does **not** include the artists'/composer's production hours (that's money + calendar, see §7). You already have the music list.
- **Character-generation system is optional** — shown as a separate add-on line, not in the base totals.
- **Complex ("hero") track count scales ~15–20%**, floored at the 3 the doc names (first, last, day→night). This gives: **7 tracks → 3 complex / 4 simple**, **14 → 3 / 11**, **28 → 5 / 23**.
- Single platform first (Windows, itch.io). Controller + keyboard supported (already partly wired).
- Godot 4.3, 2D pixel-art, 640×360 internal resolution (matches the POC).
- No fail-state, no online, no achievements beyond a local score/grade (matches the doc).

---

## 2. Current POC status — what the prototype already proves

The POC is a **vertical slice of one complex track (Chakra)** — deliberately the highest-risk part of the whole game. The hard "does the core even work" question is answered.

**Done / working:**
- **DJ segment-sequencer** — plays a full ~8-min track as ~17 seamless segments, with 5 transition types (auto-advance, loop-until-position, wait-for-jump, wait-until-position, loop-until-tutorial). This is the seamless-loop backbone the doc calls for.
- **Beat engine** — Guitar-Hero-style falling notes, timing window + hit detection, per-track hit counting and an end-of-track score (hits/total, %). Directions: none / left / right / center.
- **Player** — `CharacterBody2D` state machine (stand / walk / sprint / jump / fall), auto-runner, and bespoke set-pieces (per-track gravity inversion, full-screen rotation for the bird section, camera offset).
- **Music-synced NPC animation** — drummer, guitarist, singer, Sahi, bird, bystanders driven by playback position via an animation-sequencer.
- **Tutorial** — loop-until-mastered logic.
- Placeholder pixel art + placeholder audio segments; input maps for keyboard/mouse/gamepad; pixel-perfect render config.

**Deliberate POC debt (must be paid to scale past 1 track):**
- Everything is **hardcoded per track name** — beat maps are hand-typed dictionaries, and mechanics (gravity flips, rotations, teleports) are `if track == "song3.wav"` branches in the player. This does **not** scale to 7–28 tracks; it needs to become data-driven. This is the single biggest line item below.
- **No festival half at all** — no exploration world, dialogue, NPCs-you-can-talk-to, menus, save/load, time-of-day, or track-select/completion flow. The POC is only the "inside a track" experience.

**Rule of thumb: the POC represents most of the risk but a minority of the total work.**

---

## 3. Estimation model

### 3a. Common / one-time work (the "game", minus the tracks)

| # | System | Weeks (nominal) | Notes |
|---|--------|:---:|-------|
| 1 | **Rhythm-engine generalization** — data-driven track defs, external beat-map files, mechanics-as-data (replace the hardcoded `if track ==` branches) | 4.0 | Prerequisite for every track after the first |
| 2 | **Beat-mapping tool/workflow** — tap-to-audio authoring so you're not hand-typing dictionaries | 1.5 | Pays for itself fast at 7+ tracks |
| 3 | **Festival exploration systems** — explore-mode controller/camera, level framework, parallax, NPC spawning, collision, per-location assembly | 4.0 | Art is outsourced; assembly/logic is not |
| 4 | **Dialogue system** — text box, portraits, speaker indicators, data format, proximity/auto/post-track triggers (recommend the **Dialogic** plugin) | 2.5 | |
| 5 | **Time-of-day & progression/gating** — day→dusk→night→dawn, track ordering, area/conversation gating, palette/lighting shifts | 2.0 | |
| 6 | **Menus** — main, pause, options (audio/video/controls + remap), credits | 2.0 | |
| 7 | **Save/load** — auto-save after each track; completion, scores, time state | 1.0 | |
| 8 | **Track-complete & scoring UI** — artist/track/length, high score, grade (S/A/B…), retry | 1.0 | |
| 9 | **Audio system** — festival ambient beds, volume ducking near stages, SFX bus/integration | 1.0 | |
| 10 | **Narrative & conversation writing** — script for Sahi/Kara/Barry/Unnamed + one-offs | 1.5 | |
| 11 | **Outsourcing overhead** — asset specs/briefs, review cycles, import + hook-up of all commissioned art/audio across the game | 3.0 | Real cost of the outsourced pipeline |
| 12 | **Global polish** — settings, controller support, pause behaviour in tracks, accessibility, QA hardening | 3.0 | |
| 13 | **itch.io release** — build pipeline, store page, capsule art coordination, trailer, QA pass, bug-fix | 2.5 | |
| | **Common subtotal** | **~29 wk** | (~6.75 months); realistic range **26–34 wk** |

### 3b. Per-track cost

**Per complex ("hero") track** — bespoke Chakra-style set-piece with a wordless story, custom mechanics, custom fantasy scenes:

| Task | Weeks |
|------|:---:|
| Narrative/scene design & choreography | 0.75 |
| Bespoke mechanics & scripting (set-pieces, camera, gravity/rotation) | 1.5 |
| Beat-mapping & tuning (8+ min) | 0.75 |
| Integrate bespoke commissioned art + music-synced animations | 1.0 |
| Audio segmentation into seamless loop parts + wiring | 0.5 |
| Test / polish | 0.5 |
| **Per complex track** | **~5.0 wk** (range 4–6) |

**Per simple track** — Guitar-Hero / auto-runner style, reused mechanics & environments:

| Task | Weeks |
|------|:---:|
| Beat-mapping & tuning | 0.5 |
| Scene assembly from reusable environments + light custom touches | 0.4 |
| Audio segmentation / wiring (simpler) | 0.25 |
| Test / polish | 0.25 |
| **Per simple track** | **~1.4 wk** (range 1–2) |

**Chakra credit:** the first complex track is ~50–60% built in the POC (mechanics, segmentation, beat map exist; needs re-fitting onto the generalized engine + final art). Credit ≈ **−2.5 wk** against the first complex track.

---

## 4. Scenario totals

Nominal = the table math. **Realistic = nominal + ~30% contingency** (the number to actually plan around).

| Set size | Mix | Track dev | + Common | Nominal | **Realistic (≈+30%)** | **≈ Months (realistic)** |
|---|---|:---:|:---:|:---:|:---:|:---:|
| **7 tracks (~1 h set)** | 3 complex / 4 simple | 15 + 5.6 − 2.5 = **18.1** | 29 | **~47 wk** | **~61 wk** | **~14 months** |
| **14 tracks (~2 h set)** | 3 complex / 11 simple | 15 + 15.4 − 2.5 = **27.9** | 29 | **~57 wk** | **~74 wk** | **~17 months** |
| **28 tracks (~4 h set)** | 5 complex / 23 simple | 25 + 32.2 − 2.5 = **54.7** | 29 | **~84 wk** | **~109 wk** | **~25 months** |

**Read the "Realistic / Months" columns as the plan.** The nominal columns assume nothing goes wrong, which for a solo multi-year project it won't.

### Recommendation
The **7-track set (~14 months realistic)** is the right first commercial target. It's a complete, shippable "set," front-loads the expensive common systems only once, and lets you validate sales before committing another 6–12 months to more tracks. Additional tracks are cheap *after* shipping — roughly **+1.4 wk per simple track**, so a post-launch content update or a bigger "director's cut" is low-risk incremental work, not a rebuild.

---

## 5. Optional add-ons (not in the totals above)

| Add-on | Cost | Note |
|--------|:---:|------|
| **Procedural character-generation system** (modular parts for varied attendants + player male/female) | +2.5–3 wk | Your "time permitting" item. Can be down-scoped to a handful of hand-made attendant variants for ~0.5 wk. Rabbit-hole risk — timebox it. |
| **Extra platforms** (Linux / macOS export + test) | +1.5–2 wk each | Godot exports easily; the cost is testing/support, not porting. |
| **Steam release** (on top of itch) | +1.5–2 wk | Steamworks integration, store page, review process. |
| **Localization** (per language) | +0.5 wk + translation cost | Build text-driven from the start to keep this cheap later. |

---

## 6. Suggested build order (de-risks the schedule)

1. **Engine generalization + beat-mapping tool** (§3a #1–2) — unblocks all tracks; do this first.
2. **Re-fit Chakra** onto the generalized engine — proves the refactor against the one track you already understand.
3. **Festival + dialogue + time-of-day** (the untested half) — this is where unknowns hide; find them early.
4. **Menus / save / track-complete UI** — makes it a "game" you can play end-to-end.
5. **Content pass** — author the remaining tracks (cheap and parallelizable with art delivery).
6. **Polish → release.**

---

## 7. External asset production (money + calendar, runs in parallel)

Because art/audio is outsourced, this is a **budget + lead-time** stream, not developer hours (your integration time is already in §3a #11 and the per-track lines). Two things to manage:

- **Lead time > your time.** Commissioned art arrives on the artist's schedule. Brief early, brief in batches, and keep placeholders in-engine so your progress never blocks on a delivery.
- **Segmentation is on you (or your composer).** Every track must be cut into seamless, loopable segments the way the POC's Chakra track is (start / loop / guitar-loop / singer / song / …). Budget this per track — trivial for simple tracks, involved for complex ones. Specify it explicitly in the composer brief or plan to do it yourself in a DAW.

The asset **list** below doubles as your commissioning brief.

---

## 8. Art asset list

### Characters (each = a full animation set: idle, walk, run, jump, fall, dash, dance, beat-press + track-specific)
- **Player character** — male + female variants
- **Sahi** (cheerful, sober friend)
- **Kara** (blond, confident)
- **Barry** (dances at 2× speed — needs a distinct fast dance set)
- **Unnamed** (dancer; interacts through dance, rarely speaks — dance-heavy set)
- **Blackness** (amorphous, track-only; represents the "downs" — needs a fluid/morph treatment, likely shader + sprite)
- **Musicians:** Drummer, Guitarist, Singer — each with beat-synced "playing" animations
- **Festival crowd / NPCs** — non-interactable attendant variants (this is where char-gen, if built, pays off; otherwise ~6–12 hand-made variants + recolors)
- **Fantasy / track-only characters** — giant bird, angels, aliens, stars, etc. (per complex track; bespoke)

### Environments & backgrounds
- **Festival locations:** entrance, hill + small lake, tent area, open desert, big lake + boat, stages, food court, general grounds (+ connective areas)
- **Parallax background layer sets** per location
- **Time-of-day variants** — day / dusk / night / dawn palettes & lighting for the festival (can be shader/palette-driven rather than redrawn — spec this to save cost)
- **Track fantasy environments** — clouds, space, jungle, free-fall skies, etc.; **bespoke per complex track**
- **Tilesets** for platforming (festival + track sections)

### UI
- Falling-beat / note sprites (left / right / center / none) + hit & miss states
- Button-prompt icons — **keyboard + controller** sets
- Dialogue box + character portraits (with a couple of expressions each for speaking characters)
- Speaker name/color indicators; on-map "talkable" indicator
- Track-complete panel + grade icons (S/A/B/C…)
- Main menu, pause menu, options screens, credits
- Tutorial prompt art
- Title / logo art
- **Store art:** itch.io cover/capsule, screenshots, trailer (trailer is separate video work)

### VFX / particles / shaders
- Beat-hit feedback (particles / flash / animation — the doc's positive feedback)
- Miss feedback (mark the beat, grey-out / volume-dip visual)
- **Psychedelic set-piece effects** (per complex track — the "psychedelic art" pillar; the most bespoke, highest-value art)
- Festival↔track transition effects; power-move effect
- Ambient particles (dust, stage lights, etc.)

---

## 9. Audio asset list (non-music — you have the music list)

- **Player SFX:** footsteps (walk/run), jump, land, dash
- **Conversation blips** — per character or a shared set (speaker-tinted)
- **UI SFX:** navigate, select, back, pause/unpause
- **Festival ambience** — crowd bed, distant-stage bleed, per-area soundscape (with volume ducking handled in-engine)
- **Beat feedback:** per the doc, hits have **no audio feedback**; misses at most a subtle volume dip. So keep track-side SFX minimal by design.
- **Music (already listed) — plus, per track:** segmentation into seamless loopable parts (see §7). Call this out in the composer brief.

> Note: the doc specifies music-track levels use *only* the music (no SFX during tracks). So the SFX list above is almost entirely for the **festival** half.

---

## 10. Key risks & watch-items

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Engine generalization is under-scoped (POC is very hardcoded) | Delays every track | Do it first (§6.1); budget the full 4 wk |
| Festival half is completely untested | Hidden unknowns | Prototype it early (§6.3), before committing to a big track count |
| Outsourced-art lead times block progress | Schedule slips | Batch briefs, keep placeholders, never idle on a delivery |
| Char-gen rabbit hole | Weeks lost | Timebox or cut to hand-made variants |
| Beat-authoring by hand doesn't scale | Slow content phase | Build the tap-to-audio tool (§3a #2) |
| Solo-project overrun (the base rate) | Everything later | Plan around the **Realistic** column, not nominal; ship the 7-track set first |

---

_Bottom line: the POC has retired the core technical risk. Realistically budget **~14 months** for a shippable 7-track commercial set, **~17 months** for 14 tracks, and **~25 months** for a 28-track "full set" — plus an outsourced art/audio budget running in parallel. Ship the small set first; further tracks are cheap afterward._
