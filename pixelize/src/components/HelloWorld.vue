
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
import axios from 'axios';

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
      this.imageData.data[3] = 255;
    },
    drawArea: function(pixels) {
      for(const pixel of pixels) {
        const {color: rgb} = pixel;
        this.canvas.strokeStyle = 'rgb(' + rgb[0] + ',' + rgb[1] + ',' + rgb[2] + ')';
        this.imageData.data[0] = rgb[0];
        this.imageData.data[1] = rgb[1];
        this.imageData.data[2] = rgb[2];
        this.canvas.putImageData(this.imageData, pixel.coordinates[0], pixel.coordinates[1]);
      }
    },
    updateColor: function(e) {
      this.inputColor = [e.colors.rgb.r * 256,e.colors.rgb.g * 256,e.colors.rgb.b * 256]
    },
    getRandomColor: () => Array.apply(null, Array(3)).map(() => Math.floor(Math.random() * 256)),
    capturePoint: function (coordinates, color) {
        const area = this.calcuateArea(coordinates, color);
        axios.post('/pixels/create_bulk', {
          range: area,
          color: this.inputColor
        }).then(this.getAndDrawAll());
        this.drawArea(area);
    },
    getAndDrawAll: function() {
      axios.get('/pixels').then(r => {
          this.drawArea(r);
      })
    },
    submitCoordinatesForm: function () {
      this.capturePoint(this.inputCoords, this.inputColor);
    },
    calcuateArea: function (coordinates, color) {
      const {x,y} = coordinates;
      const area = [];
      for(var i = x; i < x + 5; i++) {
        for(var j = y; j < y + 5; j++) {
          area.push({coordinates: [i,j], color});
        }
      }
      return area;
    },
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
