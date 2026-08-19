# runs as the observer, positioned at the parent's probe center. recurse into the near half (step back
# along the ray) and the far half (step forward), each with half the radius. caret coords use the current
# position and the observer's unchanged facing, so the steps march straight along the view ray. only a
# child whose sphere holds the looked-at wearer will probe true and recurse deeper.
$execute positioned ^ ^ ^$(negstep) run function ehead:ehead2/head/seen_search with storage ehead:ehead2 seen
$execute positioned ^ ^ ^$(step) run function ehead:ehead2/head/seen_search with storage ehead:ehead2 seen
