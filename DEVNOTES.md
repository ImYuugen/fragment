# Plugin System
How can we implement a (dynamically loaded) plugin system for this engine ?
There are many technologies out there to help us in this endeavour.
Let's rank them with different criterias:
- Performance
- Safety
- Cross platform support
- Ease of implementation
- Flexibility
(Gradings are backed by pure vibes at the time of writing)

### Scripting languages
Scripting languages could be used to interface with the internal API.
Lua is awesome, its JIT is very fast and it's easy to learn, you can
sandbox its runtime, and there are libraries available in many languages
(that means plugin devs are not confined to Rust)
- Performance: 8/10
- Safety: 10/10 (no need for `unsafe` (mostly))
- Cross platform: 10/10
- Ease of impl: 8/10 (idfk lmao)
- Flexibility: 9/10 (Lua + languages that can interface with Lua)

### FFI
You could make a Plugin Dev Kit, you need an FFI to communicate with it.
No overhead, very unsafe, tough to implement well, that's about it.
Also Rust's FFI is hot garbo as of June 2024.
And honestly if you choose that option might as well do C
- Performance: 10/10
- Safety: 5/10 (Depends on the dev, could be good or could be terrible)
- Cross platform: 5/10 (ABI might depend on platform (?))
- Ease of impl: 6/10 (idk, but it doesn't sound easy)
- Flexibility: 10/10 (Any language that can call extern functions)

### Wasm
Cool tech, more overhead than Lua, VERY WELL implemented in Rust,
very safe, not platform dependant, hard to learn (to me at least)
Very solid option.
- Performance: 7/10
- Safety: 10/10 (no need for `unsafe` keyword at all)
- Cross platform: 10/10
- Ease of impl: ?/10 (probably lower than 8)
- Flexibility: 10/10 (wasi)

## So yeah
I think I might end up using Lua for interfacing with the main program
said Lua can interface with an arbitrary language to run more complex
calculations to reduce overhead (testing needed)

A close second is WASM, pretty much any language can compile to WASM,
the Rust lib is great, and it's safe.
Only problem, it might be harder to comprehend/implement, so I might
do that after Lua works well to add options (low-prio)

If for some reason these two are not fast enough, I might delve into
the dark world of FFIs, I hope it does not come down to this, simply
because I have *la flemme*

---
