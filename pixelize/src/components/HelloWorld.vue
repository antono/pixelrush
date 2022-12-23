
<template>
  <section class="canvars-container">
    <div class="canvas-controls">
      <ColorPicker :visible-formats="['rgb']" @color-change="updateColor"></ColorPicker>
      <button @click="submitCoordinatesForm()" type="button">Own</button>
    </div>
    <canvas id="c" width="1000" height="1000"></canvas>
  </section>
</template>

<script>
import { ColorPicker } from 'vue-accessible-color-picker'

export default {
  name: 'HelloWorld',
  components: {
    ColorPicker,
  },
  data() {
    return {
      canvas: null,
      imageData: null,
      inputCoords: {
        x: 0,
        y: 0,
      },
      inputColor: [255,255,255]
    }
  },
  mounted() {
    var c = document.getElementById("c");
    var ctx = c.getContext("2d");
    this.canvas = ctx;
    this.drawEmpty();
    document.getElementsByTagName('canvas')[0].addEventListener('click', this.onCanvasClick.bind(this))
  },
  methods: {
    drawEmpty: function() {
      this.canvas.clearRect(0, 0, 1000, 1000);
      this.imageData = this.canvas.createImageData(1, 1);
      var color = this.getRandomColor();
      console.log(color);
      this.canvas.strokeStyle = 'rgb(' + color[0] + ',' + color[1] + ',' + color[2] + ')';
      this.imageData.data[0] = color[0];
      this.imageData.data[1] = color[1];
      this.imageData.data[2] = color[2];
      this.imageData.data[3] = 255;
      // for(var i = 120; i < 550; i++) {
        this.canvas.putImageData(this.imageData, 0, 0);
      // }
    },
    drawPoint: function(coordinates, color) {
      const {x,y} = coordinates;
      this.canvas.strokeStyle = 'rgb(' + color[0] + ',' + color[1] + ',' + color[2] + ')';
      this.imageData.data[0] = color[0];
      this.imageData.data[1] = color[1];
      this.imageData.data[2] = color[2];
      for(var i = x; i < x + 10; i++) {
        for(var j = y; j < y + 10; j++) {
          this.canvas.putImageData(this.imageData, i, j);
        }
      }
    },
    updateColor: function(e) {
      this.inputColor = [e.colors.rgb.r * 256,e.colors.rgb.g * 256,e.colors.rgb.b * 256]
    },
    getRandomColor: () => Array.apply(null, Array(3)).map(() => Math.floor(Math.random() * 256)),
    capturePoint: function (coordinates, color) {
      if(!this.isOwned(this.inputCoords)) {
        this.drawPoint(coordinates, color);
      } else {
        alert('already owned');
      }
    },
    submitCoordinatesForm: function () {
      this.capturePoint(this.inputCoords, this.inputColor);
    },
    isOwned: () => false,
    onCanvasClick: function (e) {
      console.log(this.inputColor);
      this.capturePoint({x: e.offsetX, y: e.offsetY}, this.inputColor);
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
#c {
  border: 1px solid gray;
}
.canvars-container {
  display: flex;
  flex-direction: row;
}
</style>
