<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>高端大气上档次_音乐播放器</title>
    <meta name="viewport" content="width=device-width,inital-scale=1" charset="UTF-8">
    <link href="/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet">
</head>
<body>

<div class="container center-block">
    <h1 class="text-center">高端大气上档次音乐播发器</h1><br>

    <div class="row center-block">
        <div class="col-lg-3"></div>
        <div class="col-lg-6">
            <div class="input-group">
                <div class="input-group-btn">
                    <select class="selectpicker form-control" data-live-search="true" id="check">
                        <option selected>忽略检测</option>
                        <option>启用检测</option>
                    </select>

                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        检测下载啊
                        <span class="caret"></span>
                    </button>
                </div>
                <input type="text" id="keyWord" placeholder="请输入关键词" class="form-control">
                <span class="input-group-btn">
                        <span onclick="search()" class="btn btn-success">搜索</span>
                    </span>
            </div>
        </div>
        <div class="col-lg-3"></div>
    </div>
    <hr>

    <div id="result" style="display: none">
        <table class="table table-responsive table-hover table-bordered table-condensed text-center">
            <tbody style="font-weight: bold" id="corBody">
            </tbody>
        </table>
        <div class="">
            <!---col-md-offset-4 col-md-4 text-center--->
            <span onclick="getMore()" class="btn btn-md btn-warning center-block">更多</span>
        </div>
        <hr>
        <br>
    </div>

    <div id="infoBox" style="display:none; z-index: 1000; position: absolute; top: 30%; right:20%; left:20%;">
        <div class="container well" style="width:90%;">
            <div style="text-align: right; margin-bottom: 5px">
                <span class="btn btn-danger btn-sm" onclick="$('#infoBox').hide()">X</span>
            </div>
            <div id="infoContent" class="text-center"></div>
            <br>
        </div>
    </div>
</div>

</body>
<script type="text/javascript" src="/js/jquery-3.2.1.js"></script>
<script>
    songData = {};
    p = 0;
    // 点击搜索
    function search() {
        $('#corBody').html("");
        var ori = '<tr><td>歌曲名</td> <td>歌手名</td> <td>唱片名</td> <td>下载链接</td></tr>';
        $('#corBody').append(ori);
        p = 0;
        getData();
    }
    // 获取数据
    function getData(){
        p += 1;
        check = 'no';
        if($('#check').val() == '启用检测')
            check = 'yes';
        $.ajax({
            url: '/getsong?p='+p+'&word='+$('#keyWord').val()+'&check='+check,
            type: 'POST',   // GET POST
            async: true,    // 或false,是否异步
            scriptCharset: 'UTF-8',
            //contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            timeout: 30*1000,       // 超时时间
            dataType: 'text',    // 返回的数据格式：json/xml/html/script/jsonp/text
            success: function (data, textStatus, jqXHR) {
                songData = eval(data);
                result_show();
            },
            error: function (xhr, textStatus) {
                console.log('发生错误');
                $('#infoBox').show();
                $('#infoContent').html('警告: 获取数据失败!');
            }
        });
    }
    function result_show() {

        while(JSON.stringify(songData) == '{}')
            continue;
        if(songData == null){
            console.log('发生错误');
            $('#infoBox').show();
            $('#infoContent').html('警告: 获取数据失败!');
            return false;
        }
        $('#result').show();
        for(var i=0; i < songData.length; i++) {
            var song = songData[i];
            var s = '<tr><td>'+song.songname+'</td><td>'+song.singer+'</td><td>'+song.albumname+'</td>\r\n';
            var d = '<td>';
            if(song.flac != undefined)
                d += '<a class="btn-danger btn-sm btn" href="'+song.flac+'">Flac</a> ';
            if(song.ape != undefined)
                d += '<a class="btn-warning btn-sm btn" href="'+song.ape+'">Ape</a> ';
            if(song.mp3320 != undefined)
                d += '<a class="btn-success btn-sm btn" href="'+song.mp3320+'">320</a> ';
            if(song.mp3128 != undefined)
                d += '<a class="btn-default btn-sm btn" href="'+song.mp3128+'">128</a> ';
            d+= '</td></tr>';
            $('#corBody').append(s+d);
        }
        songData = {};
    }
    // 更多
    function getMore() {
        songData = getData();
        // ajax获取, 等待实现
        if(JSON.stringify(songData) == '{}'){
            $('#infoBox').show();
            $('#infoContent').html('没有更多啦!');
            return;
        }
        result_show();
    }
</script>
</html>
