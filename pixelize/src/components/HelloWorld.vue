<template>
  <section class="canvars-container">
    <div class="canvas-controls">
      <div>
        <label for="x">X</label>
        <input v-model="inputCoords.x" type="number" min="0" max="1000" name="x" id="x"/>
      </div>
      <div>
        <label for="y">Y</label>
        <input v-model="inputCoords.y" type="number" min="0" max="1000"  name="y" id="y"/>
      </div>
      <button @click="capturePoint()" type="button">Own</button>
    </div>
    <canvas id="c" width="1000" height="1000"></canvas>
  </section>
</template>

<script>
export default {
  name: 'HelloWorld',
  data() {
    return {
      canvas: null,
      imageData: null,
      inputCoords: {
        x: 0,
        y: 0,
      }
    }
  },
  mounted() {
    var c = document.getElementById("c");
    var ctx = c.getContext("2d");
    this.canvas = ctx;
    this.drawEmpty();
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
      this.canvas.strokeStyle = 'rgb(' + color[0] + ',' + color[1] + ',' + color[2] + ')';
      this.imageData.data[0] = color[0];
      this.imageData.data[1] = color[1];
      this.imageData.data[2] = color[2];
      this.canvas.putImageData(this.imageData, coordinates.x, coordinates.y);
    },
    getRandomColor: () => Array.apply(null, Array(3)).map(() => Math.floor(Math.random() * 256)),
    capturePoint: function () {
      if(!this.isOwned(this.inputCoords)) {
        this.drawPoint(this.inputCoords, [123,32,42]);
      } else {
        alert('already owned');
      }
    },
    isOwned: () => false,
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
