<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Attach file(s) list of Depreciation Slip</title>
</head>

<script type="text/javascript" language="javascript">
    var PK              =0,
        FILENAME        =1,
        FILESIZE        =2,
        CONTENTTYPE     =3,
        REMARKS         =4,
        TLG_MA_ASSET_PK =5;


    //=======================================================================
    function AttachFiles() {
        txtAssetPK.text = '<%=Request.Querystring("pk") %>';
        if (txtAssetPK.text != '') {
            imgFile.MasterPK = txtAssetPK.text;
            imgFile.ChangeImage();
            if (imgFile.oid == 0) {
                return false;
            }
            else {
                data_fpma00212.Call('SELECT');
            }
            imgFile.oid = "";
        }
        else {
            alert('Please select one Depreciation Slip!!');
        }
    }

//=======================================================================
 
function BodyInit()
{
    System.Translate(document);    
    //var image_pk = 1 ;
    //imgAsset.SetDataText(image_pk);
    //-------------------------
    txtAssetPK.text = '<%=Request.Querystring("pk") %>';
    data_fpma00212.Call("SELECT");
}  
//=======================================================================
function OnDataReceive(pos)
{
    //imgAsset.SetDataText(txtImagePK.text);
}
//=======================================================================
function OnSave()
{
    data_fpma00212.Call();
}
//=======================================================================
function OnRefresh() {
    txtAssetPK.text = '<%=Request.Querystring("pk") %>';
    data_fpma00212.Call();
}

//=======================================================================
function OnDelete()
{
    if (grdAttach.rows - 1 > 0) 
    {
        grdAttach.DeleteRow();
    }
}

//=======================================================================
function OnDownload() {
    if (grdAttach.rows > 0)
     {
        var filepk = grdAttach.GetGridData( grdAttach.row, PK );
        if(filepk!='')
        {
            var url = System.RootURL + '/form/fp/ma/fpma00024_DownFile.aspx?img_pk=' + filepk + '&table_name=TLG_MA_DEPR_SLIP_FILES';
	        System.OpenTargetPage( url , 'newform' ); 
        }
    }
}
//=======================================================================
function OnOpenFile() {
    var img_pk = grdAttach.GetGridData(grdAttach.GetGridControl().row, PK);
    var url = System.RootURL + "/system/binary/viewfile.aspx?img_pk=" + img_pk + "&table_name=TLG_MA_DEPR_SLIP_FILES";
    window.open(url);
}
//=======================================================================
</script>

<body>
	<!---------------------------------------------------------------->
    <gw:data id="data_fpma00212" onreceive="OnDataReceive(this)"> 
    	<xml> 
	        <dso  id="1" type="grid" parameter="0,4,5" function="<%=l_user%>lg_sel_fpma00212"  procedure="<%=l_user%>lg_upd_fpma00212">
	            <input>
	                 <input  bind="txtAssetPK" /> 
	            </input>
	                <output bind="grdAttach" /> 
	        </dso> 
    	</xml> 
    </gw:data>
    <!---------------------------------------------------------------->

                    header='_PK|File Name|File Size|File Type|Remark|_TLG_MA_ASSET_PK'
                    format='0|0|0|0|0|0'
                    aligns='0|0|3|0|0|0'
                    check='|||||'
                    editcol='0|0|0|0|1|0'
                    widths='1000|3500|1000|2000|1000|1000'
                    styles="width:100%; height:100%"   
                    />
</body>
<!---------------------------------------------------------------------->
<gw:image id="imgFile" table_name="<%=l_user %>TLG_MA_DEPR_SLIP_FILES" procedure="<%=l_user %>lg_upd_fpma00212_files" view="/binary/ViewFile.aspx"
        
<gw:textbox id="txtAssetPK" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtImagePK" maxlen="100" styles='width:100%;display:none' />
</html>