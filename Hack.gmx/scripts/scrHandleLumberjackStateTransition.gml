/// scrHandleLumberjackStateTransition

if(state != newState) {
    // State exit functions
    if(state == IDLE) {
        alarm[0] = -1;
    }

    // State transitions
    if(state == IDLE) {
        if(newState == WALKING) {
            MFLog("Idle to walking.");
        }
    } else if(state == WALKING) {
        if(newState == IDLE) {
            MFLog("Walking to idle.");
        }
    } else {
        MFLog("Unhandled state transition. " + string(state) + " to " + string(newState));
    }
    
    // State entry functions
    if(newState == WALKING) {
        MFLog("Entering walking state.");
        destX = irandom(room_width - 50) + 25;
        destY = irandom(room_height - 50) + 25;
        movementSpeed = (random(100.0) + 80.0)/room_speed;
        image_speed = 12.0*movementSpeed/room_speed; // 10.0 looks good
    } else if(newState == IDLE) {
        alarm[0] = irandom(maximumIdleTime - minimumIdleTime) + minimumIdleTime;
        sprite_index = 12;
        image_speed = (random(2.0) + 9.0)/room_speed;
    } else if(newState == STALKING) {
        show_debug_message("Entering stalking state.");
        if(currentTarget == noone) {
            var lumberjackList = ds_list_create();
            with(objLumberjack) {
                ds_list_add(lumberjackList, self);
            }
            currentTarget = ds_list_find_value(lumberjackList, irandom(ds_list_size(lumberjackList)-1));
        }
        destX = currentTarget.x;
        destY = currentTarget.y;
        movementSpeed = (random(100.0) + 80.0)/room_speed;
        image_speed = 12.0*movementSpeed/room_speed; // 10.0 looks good
        newState = WALKING;
    }
    
    
    // Update the current state
    state = newState;
}
