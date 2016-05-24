sample_bulk_reg_file.csv - sample CSV file for bulk registration:

Registration Key is ETH0 mac
Hardware ID is the WLAN0 mac


REGISTRATION_KEY, HARDWARE_ID, DEVICE_NAME, CATEGORY_A, CATEGORY_B, CATEGORY_C, CATEGORY_D, CATEGORY_E, CATEGORY_F, CATEGORY_G, CATEGORY_H, CATEGORY_I, CATEGORY_J
1c:49:7b:55:a5:58, 1c:49:7b:29:fe:e2,Cap 2,School 1,Library, , , , , , , ,




update-rc.d weaved defaults 99 10
update-rc.d -f weaved enable

update-rc.d weaved.schannel defaults 99 10
update-rc.d -f weaved.schannel enable

If you have old links to refresh them with the new levels:
update-rc.d -f weaved remove
update-rc.d -f weaved.schannel remove

Then redo above


~
