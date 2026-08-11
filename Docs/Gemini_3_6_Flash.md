# Commercial Game Development Estimation & Asset Checklist
**Project:** Trance (2D Rhythm Platformer / Festival Exploration)  
**Target Platform:** PC (Itch.io Commercial Release)  
**Developer Setup:** 1 Solo Developer, Full-Time (40 Hours / Week = ~160 Hours / Month)  
**Engine:** Godot Engine 4  
**Date:** August 2026  

---

## 1. Overview & Prototype Analysis

The game *Trance* combines two primary gameplay loops:
1. **Festival Exploration (2D Side-scrolling Platformer/Adventure):** Walking, sprinting, jumping, conversing with friends/attendants, exploring festival grounds across a 24-hour time-of-day cycle (Day, Dusk, Night, Dawn).
2. **Rhythm Sections (8+ minute Psytrance Tracks):** Syncing button presses to beats without a traditional fail state, with dynamic camera movements, auto-running, free-falling, screen rotations, and narrative-driven environment transformations.

### Current Prototype State (Godot 4 POC)
- Basic player state machine (`Stand`, `Walk`, `Sprint`, `Jump`, `Fall`).
- Basic `DJ` audio controller managing sequential audio streams and track transitions.
- Hardcoded beat dictionaries and falling beat receptor system.
- Initial narrative/gameplay sequence for the **Chakra** prototype track (parts 1–14).

To transition from this prototype to a commercial release on Itch.io, key production pipelines must be built—specifically a **Beat Charting Pipeline/Tool** (avoiding GDScript hardcoded beat timestamps), a **Dialogue & Event System**, a **Time-of-Day Lighting System**, and a robust **UI/UX Framework**.

---

## 2. Core Systems Estimation (One-Time Setup)

These core framework components are required regardless of the number of songs implemented.

| Category | Component / Feature | Est. Hours | Est. Weeks (40h/w) |
| :--- | :--- | :---: | :---: |
| **Beat Charting & Tooling** | Custom Beat Map Editor / MIDI import pipeline, JSON parser, latency calibration system & audio/visual sync offset tool | 60 h | 1.5 wks |
| **Rhythm Mechanics Core** | Hit detection windows (Perfect/Great/Good/Miss), beat pooling, input remapping, pitch/volume miss dampening, visual pulse feedback | 40 h | 1.0 wk |
| **Festival & World Systems** | 2D World layout setup, area triggers, Time-of-Day system (CanvasModulate / Shaders for Day/Dusk/Night/Dawn), crowd spawn manager | 50 h | 1.25 wks |
| **Dialogue & Narrative** | Typewriter text box system, character portrait manager, dialogue triggers, branching text logic, sound blips | 30 h | 0.75 wks |
| **UI / UX Framework** | Main menu, pause menu, audio sliders (Music/SFX/Master), controller setup, track results summary card (Artist, Score %, Grade S/A/B/C) | 40 h | 1.0 wk |
| **Save / Load & Progression**| Save system (unlocked tracks, high scores, time-of-day progression, settings persistence via ConfigFile/JSON) | 15 h | 0.38 wks |
| **Polishing & Itch.io Prep** | Controller support & mapping, resolution scaling, build export optimization (Windows/Mac/Linux), Itch.io store assets & page integration | 35 h | 0.88 wks |
| **TOTAL CORE SYSTEMS** | | **270 Hours** | **~6.75 Weeks** |

---

## 3. Per-Song Development Estimation

Psytrance tracks in this game average **8.5 minutes** in duration (~130–145 BPM, ~800 to 1,500 beats per track). The design document specifies two levels of song complexity.

### A. Simpler Song (Standard Rhythm Track)
*Description:* Standard auto-runner or scrolling rhythm track (similar to typical Guitar Hero / Rayman Legends rhythm levels) taking place over standard festival stages or theme backdrops without complex narrative scripted events.
- Audio preparation & track slicing: 3 h
- Beat charting & timing sync: 12 h
- Visual background / stage backdrop setup: 5 h
- Playtesting, hit window tuning, and difficulty balance: 5 h
- **Total per Simpler Song:** **~25 Hours (~0.6 Weeks)**

### B. Complex Song (Narrative / Multi-Part with Custom Mechanics)
*Description:* Like the *Chakra* prototype track (Parts 1–14). Features multi-part narrative transitions, custom gameplay mechanics (e.g., gravity inversion, 360° screen rotation, freefall/dash sections, flying), interactive character sync (drummer, guitarist, singer, giant bird, crowd responses), and seamless looping/walking section triggers.
- Multi-track audio slicing & seamlessly looping transition logic: 10 h
- Scripted event sequencing (`AnimationSequencer` triggers, camera offsets, screen rotation FX): 25 h
- Custom mechanics implementation (gravity shifts, air dash beats, freefall controls): 15 h
- Beat charting & timing sync for all complex sub-sections: 15 h
- Custom level art integration & environment state shifts (clouds, space, fantasy): 10 h
- Playtesting, timing iteration, and bug fixing: 10 h
- **Total per Complex Song:** **~85 Hours (~2.1 Weeks)**

---

## 4. Total Project Scope & Timeline Scenarios

Assuming **1 Solo Developer** working **40 Hours / Week**:

```
Total Time = Core Systems (270h) + Festival World Art/Map (160h) + Song Track Effort + Final Polish/QA (120h)
```

| Scenario | Scope / Track Composition | Core + World + QA | Songs Effort | Total Hours | Calendar Time |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Option A: 1-Hour Set** | **7 Tracks** (3 Complex + 4 Simple) | 550 hrs | 355 hrs | **905 Hours** | **~5.7 Months** (~22.6 Wks) |
| **Option B: 2-Hour Set** | **14 Tracks** (4 Complex + 10 Simple) | 590 hrs | 590 hrs | **1,180 Hours** | **~7.4 Months** (~29.5 Wks) |
| **Option C: 4-Hour Set** | **28 Tracks** (5 Complex + 23 Simple) | 650 hrs | 1,000 hrs | **1,650 Hours** | **~10.3 Months** (~41.25 Wks) |

> **Recommendation:** Target **Option A (1-Hour Set / 7 Tracks)** for initial commercial release on Itch.io. It delivers a complete, highly polished experience with 3 landmark narrative tracks (First track, Day-to-Night transition track, Final track) and 4 simple tracks, while keeping development risk manageable for a solo developer within 6 months.

---

## 5. Asset Checklist (Art & Audio)

*Note: Music tracks are excluded as per prompt instructions.*

### 5.1 Art Assets (2D Sprites, Environments & UI)

#### A. Character Animations (2D Spritesheets)
- **Player Character (Male & Female / Customizable Base):**
  - Walk cycle
  - Run / Sprint cycle
  - Jump & Fall loop
  - Air Dash (Left, Right, Up)
  - Freefall / Power Move posture
  - Idle & Conversation gestures
- **Main Narrative Characters:**
  - **Sahi:** Walk, Idle, Dance, Cheering shout animation, Car driving pose (ending cutscene).
  - **Kara:** Walk, Idle, Confident dance animation, Dialogue expressions.
  - **Barry:** Walk, Idle, Fast dance animation (2x tempo speed), Dialogue expressions.
  - **Unnamed:** Walk, Idle, Expressive dance animation sequences.
- **Stage & Narrative Characters:**
  - **Stage Drummer:** Drumming animation synced to beat.
  - **Stage Guitarist:** Guitar playing animation.
  - **Stage Singer:** Singing animation.
  - **Blackness:** Amorphous entity (Float, Morph, Dissolve).
  - **Giant Bird:** Swoop, Fly loop, Screen rotation pose (Chakra track).
- **Festival Crowd NPCs:**
  - Base crowd sprites (10–15 variations of festival attendants dancing, chatting, sitting, standing).
  - Modular crowd parts (hair, shirt, pants color variants for population diversity).

#### B. Environments & Level Tilesets
- **Real-World Festival Grounds (Parallax & Tilesets):**
  - Festival Entrance (Gates, fence, banner)
  - Hill & Small Lake
  - Large Lake with Boat
  - Tent Campground & Open Desert
  - Festival Stages (Main Stage, Chillout Stage, DJ booths)
  - Food Court, Vendor Tents, Restroom/Decorations
  - Parallax Backgrounds: Distant desert hills, sky backdrop (Day, Dusk, Sunset, Night sky with stars, Dawn)
- **Fantasy Track Environments:**
  - Cloudscape / Aerial background (for Chakra airborne section)
  - Space / Cosmic backdrop (stars, nebulae)
  - Psychedelic Jungle backdrop (glowing plants, surreal trees)

#### C. UI & FX Graphics
- **Rhythm Mechanics UI:**
  - Beat note indicators (Left, Right, Center, Dash icons)
  - Receptor hit zones & Hit rating animations (Perfect, Great, Good, Miss)
- **Dialogue & Menus:**
  - Dialogue text box window & speaker banner
  - Character portrait frames & portraits (Sahi, Kara, Barry, Unnamed, Player)
  - Interaction prompt icons (Keyboard & Gamepad button prompts)
  - Main menu title logo ("Trance") and menu graphics
  - Track Complete summary card & Grade badges (S, A, B, C, F)
- **Visual Effects (VFX):**
  - Beat hit particle effects (glowing sparks, pulse rings, color bursts)
  - Player motion trail shader / ghost effect (for Sprint / Dash / Freefall)
  - Miss beat screen effect (desaturation / grey-out overlay shader)
  - Screen rotation & gravity shift transition shaders

---

### 5.2 Audio Assets (Sound Effects - SFX)

#### A. Player & Movement SFX
- Footstep sounds (Grass, Dirt/Sand, Wooden stage platforms)
- Jump & Landing impact sounds
- Dash / Air-dash WHOOSH sound
- Power Move activation chime/whoosh

#### B. Rhythm Mechanics SFX
- Beat hit feedback tap (subtle synth click / woodblock / clap - optional toggleable audio feedback)
- Beat miss audio dampening / low-pass filter effect

#### C. Festival & World SFX
- Ambient festival crowd chatter loop (spatial audio / volume attenuation)
- Low-pass muffled bass rumble near stages
- Water splash sound (lake jump)
- Car engine start, idling, and driving away sounds (ending sequence)

#### D. UI & System SFX
- Dialogue text scrolling blip (pitch-adjusted per character)
- UI button hover & click sounds
- Track completion victory fanfare / sound sting

---

## 6. Summary & Recommendations

1. **Build the Beat Editor Tool First:** Spending ~60 hours on a custom beat editor / MIDI parser in Godot will save hundreds of hours when charting 7–28 long (8.5 min) songs.
2. **Prioritize 1-Hour Set Scope (7 Songs):** A 6-month full-time timeline is highly achievable for a single developer while maintaining high polish and narrative depth for the complex tracks.
3. **Asset Pipeline:** Asset creation (crowd sprites, stage backgrounds, fantasy backdrops) represents roughly 20–25% of total project time; using modular sprite parts for crowd generation is critical to keep art scope under control.
