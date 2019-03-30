################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include source/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
LSS += \
DXBALL32.lss \

FLASH_IMAGE += \
DXBALL32.hex \

EEPROM_IMAGE += \
DXBALL32.eep \

SIZEDUMMY += \
sizedummy \


# All Target
all: DXBALL32.elf secondary-outputs

# Tool invocations
DXBALL32.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: AVR C Linker'
	avr-gcc -Wl,-Map,DXBALL32.map -mmcu=atmega32 -o "DXBALL32.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

DXBALL32.lss: DXBALL32.elf
	@echo 'Invoking: AVR Create Extended Listing'
	-avr-objdump -h -S DXBALL32.elf  >"DXBALL32.lss"
	@echo 'Finished building: $@'
	@echo ' '

DXBALL32.hex: DXBALL32.elf
	@echo 'Create Flash image (ihex format)'
	-avr-objcopy -R .eeprom -R .fuse -R .lock -R .signature -O ihex DXBALL32.elf  "DXBALL32.hex"
	@echo 'Finished building: $@'
	@echo ' '

DXBALL32.eep: DXBALL32.elf
	@echo 'Create eeprom image (ihex format)'
	-avr-objcopy -j .eeprom --no-change-warnings --change-section-lma .eeprom=0 -O ihex DXBALL32.elf  "DXBALL32.eep"
	@echo 'Finished building: $@'
	@echo ' '

sizedummy: DXBALL32.elf
	@echo 'Invoking: Print Size'
	-avr-size --format=avr --mcu=atmega32 DXBALL32.elf
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(FLASH_IMAGE)$(ELFS)$(OBJS)$(ASM_DEPS)$(EEPROM_IMAGE)$(S_DEPS)$(SIZEDUMMY)$(S_UPPER_DEPS)$(LSS)$(C_DEPS) DXBALL32.elf
	-@echo ' '

secondary-outputs: $(LSS) $(FLASH_IMAGE) $(EEPROM_IMAGE) $(SIZEDUMMY)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
