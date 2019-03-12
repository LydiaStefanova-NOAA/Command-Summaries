;----------------------------------------------------------------------------------
;   - Reading a variable off several grib files using 'addfiles' and 'join' mode
;----------------------------------------------------------------------------------

begin

  dataDirRoot="/scratch3/NCEPDEV/stmp1/Lydia.B.Stefanova/GDAS/"

;---The following line reads the listing in GDAS_inventory (obtained with ls -1 of the GDAS data directory)
;   and  extracts 140 lines (corresponding to a 35-day benchmark run starting on the date in / /

  fgdas_list=systemfunc ("awk '/2012020100/ { print ; for(n=0; n<16; n++) { getline ; print } }' GDAS_inventory.txt")
  fgfs_list = systemfunc ("ls /scratch3/NCEPDEV/stmp1/Lydia.B.Stefanova/fromBin/gfs.20120201/00/gfs_sflux.20120201.f0*.1x1.grib2")

;---Open all flux files using addfiles

  fgdas_flux    = addfiles (fgdas_list, "r")   ; note the "s" of addfile
  fgfs_flux    = addfiles (fgfs_list, "r")   ; note the "s" of addfile

;---Read variables in "join" mode and print a summary of the variable

  ListSetType (fgdas_flux, "join") 
  ListSetType (fgfs_flux, "join") 
   
  fgdas_lat_0=fgdas_flux[:]->lat_0
  fgdas_lon_0=fgdas_flux[:]->lon_0
  fgdas_icetk = fgdas_flux[:]->ICETK_P0_L1_GLL0   ; note syntax [:]
  fgdas_icec = fgdas_flux[:]->ICEC_P0_L1_GLL0   ; note syntax [:]
  fgdas_land = fgdas_flux[:]->LAND_P0_L1_GLL0    
  fgdas_t2m = fgdas_flux[:]->TMP_P0_L103_GLL0

  fgfs_lat_0=fgfs_flux[:]->lat_0
  fgfs_lon_0=fgfs_flux[:]->lon_0
  fgfs_icetk = fgfs_flux[:]->ICETK_P0_L1_GLL0   ; note syntax [:]
  fgfs_icec = fgfs_flux[:]->ICEC_P0_L1_GLL0   ; note syntax [:]
  fgfs_land = fgfs_flux[:]->LAND_P0_L1_GLL0    
  fgfs_t2m = fgfs_flux[:]->TMP_P0_L103_GLL0

 printVarSummary(fgfs_icetk)    

end

 wks_type                     = "X11"
 wks_type@wkWidth             = 1050
 wks_type@wkHeight            = 650

 wks                          = gsn_open_wks(wks_type,"GDAS")

 colors = (/"white","royal blue","light sky blue",\
	     "powder blue","light sea green",\
              "pale green","wheat","brown","pink","violet"/)

 res                     = True
 
 ;res@gsnMaximize         = True                          ; maximize plot in frame
 res@gsnDraw             = False                          ; don't draw
 res@gsnFrame            = False                          ; don't advance frame

 res@gsnPolar            = "NH"               ; specify the hemisphere
 res@mpMinLatF           = 50                 ; specify min lat
 res@cnFillPalette        = colors
 res@cnFillOn             = True               ; turns on the color
 res@mpFillOn             = False              ; turns off continent gray
 res@cnLinesOn            = False              ; turn off contour lines

 res@cnFillMode          = "RasterFill"
 ;res@lbLabelBarOn        = True

 res@cnLevelSelectionMode = "ManualLevels"     ; set manual contour levels
 res@cnMinLevelValF       = 0.00000001                 ; set min contour level
 res@cnMaxLevelValF       = 1.                ; set max contour level
 res@cnLevelSpacingF      = 0.2

 gdas_meanice=dim_avg_n_Wrap(fgdas_icec,0)
 gfs_meanice=dim_avg_n_Wrap(fgfs_icec,0)

 panelopts                   = True
 panelopts@gsnOrientation    = "landscape"
 panelopts@gsnPanelLabelBar  = False
 panelopts@gsnPanelRowSpec   = True
 panelopts@gsnMaximize       = True                          ; maximize plot in frame
 panelopts@gsnBoxMargin      = 0
 ;panelopts@gsnPanelBottom    = 0.2
 panelopts@gsnPanelYWhiteSpacePercent = 0
 panelopts@gsnPanelXWhiteSpacePercent = 5
 panelopts@gsnPanelMainString = "20120201, 96 hr average"
 panelopts@gsnPanelFigureStrings = (/"GDAS", "GFS"/)
 
 plot=new(2,graphic)
 plot(0)= gsn_csm_contour_map_polar(wks,gdas_meanice,res)
 plot(1)= gsn_csm_contour_map_polar(wks,gfs_meanice,res)
 gsn_panel(wks,plot,2,panelopts)
 
