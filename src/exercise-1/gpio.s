.global inputRead

inputRead:
    ldr w22, [x20, GPIO_GPLEV0]    // Read GPIO Pin Level 0 and store in X22
    and X22, X22, #0x20000         // Clear bit 17 (state of GPIO17)
    br x30                         // Return to the link instruction
