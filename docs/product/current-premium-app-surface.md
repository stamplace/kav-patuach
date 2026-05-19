# קו פתוח — Current Premium App Surface

## Status

Flutter Web app deployed through GitHub Pages.

Official demo:
https://stamplace.github.io/kav-patuach/

## Source of Truth

- Runtime: Flutter Web
- Deploy: GitHub Pages
- Workflow: Deploy Flutter Web
- Branch: main
- Vercel: not official for this product state

## Premium Assets

- kav-night-city.webp — night background
- kav-day-city.webp — day background
- kav-map-dark.webp — dark map surface
- kav-map-light.webp — light map surface
- kav-premium-glow.webp — lighting overlay
- kav-hero-poster-night.webp — trust/night hero background

## Use Cases

### Customer
Goal: open a ride request.
Flow:
1. Pickup point
2. Destination
3. Now / later
4. Time, route, trust score
5. Open request

### Driver
Goal: work live.
Flow:
1. Go online
2. See nearby calls
3. See income/trust/call count
4. Accept recommended call
5. Review queue

### Zone
Goal: understand live area operations.
Flow:
1. See active drivers
2. See open calls
3. Detect hot areas
4. Route drivers
5. Review zone events

### Admin
Goal: control operations.
Flow:
1. System metrics
2. Calls / drivers / trust
3. Today activity
4. Exceptions
5. Approvals

### Trust
Goal: explain why the service is safe.
Flow:
1. Trust score
2. Driver verification
3. Documents checked
4. Ratings and rides
5. Human support and privacy

## Current Design Principle

Images provide depth and atmosphere.
Flutter provides UI, text, actions, navigation and interaction.

## Next Improvement Passes

1. Visual QA from screenshots
2. Typography consistency
3. Spacing consistency
4. Button hierarchy
5. Light/dark refinement
6. Performance check on repeated taps
