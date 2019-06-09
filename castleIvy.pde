import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import kotlin.collections.*;
import kotlin.jvm.internal.*;
import kotlin.coroutines.*;
import kotlin.coroutines.intrinsics.*;
import kotlin.coroutines.jvm.internal.*;
import kotlin.*;
import kotlin.io.*;
import kotlin.internal.*;
import kotlin.random.*;
import kotlin.js.*;
import kotlin.reflect.*;
import kotlin.jvm.*;
import kotlin.jvm.internal.markers.*;
import kotlin.jvm.internal.unsafe.*;
import kotlin.jvm.functions.*;
import kotlin.system.*;
import kotlin.contracts.*;
import kotlin.sequences.*;
import kotlin.comparisons.*;
import kotlin.text.*;
import kotlin.experimental.*;
import kotlin.concurrent.*;
import kotlin.properties.*;
import kotlin.annotation.*;
import kotlin.ranges.*;
import kotlin.math.*;
import kotlin.coroutines.experimental.*;
import kotlin.coroutines.experimental.intrinsics.*;
import kotlin.coroutines.experimental.migration.*;
import kotlin.coroutines.experimental.jvm.internal.*;
import org.intellij.lang.annotations.*;
import org.jetbrains.annotations.*;
import tornadofx.adapters.*;
import tornadofx.*;
import tornadofx.osgi.*;
import sun.net.www.protocol.css.*;
import tornadofx.osgi.impl.*;
import org.glassfish.json.*;
import org.glassfish.json.api.*;
import javax.json.*;
import javax.json.spi.*;
import javax.json.stream.*;
import kotlin.internal.jdk8.*;
import kotlin.text.jdk8.*;
import kotlin.collections.jdk8.*;
import kotlin.streams.jdk8.*;
import kotlin.internal.jdk7.*;
import kotlin.jdk7.*;
import kotlin.reflect.full.*;
import kotlin.reflect.jvm.*;
import kotlin.reflect.jvm.internal.*;
import kotlin.reflect.jvm.internal.components.*;
import kotlin.reflect.jvm.internal.impl.builtins.*;
import kotlin.reflect.jvm.internal.impl.builtins.functions.*;
import kotlin.reflect.jvm.internal.impl.descriptors.*;
import kotlin.reflect.jvm.internal.impl.descriptors.annotations.*;
import kotlin.reflect.jvm.internal.impl.descriptors.deserialization.*;
import kotlin.reflect.jvm.internal.impl.descriptors.impl.*;
import kotlin.reflect.jvm.internal.impl.incremental.*;
import kotlin.reflect.jvm.internal.impl.incremental.components.*;
import kotlin.reflect.jvm.internal.impl.load.java.*;
import kotlin.reflect.jvm.internal.impl.load.java.components.*;
import kotlin.reflect.jvm.internal.impl.load.java.descriptors.*;
import kotlin.reflect.jvm.internal.impl.load.java.lazy.*;
import kotlin.reflect.jvm.internal.impl.load.java.lazy.descriptors.*;
import kotlin.reflect.jvm.internal.impl.load.java.lazy.types.*;
import kotlin.reflect.jvm.internal.impl.load.java.sources.*;
import kotlin.reflect.jvm.internal.impl.load.java.structure.*;
import kotlin.reflect.jvm.internal.impl.load.java.typeEnhancement.*;
import kotlin.reflect.jvm.internal.impl.load.kotlin.*;
import kotlin.reflect.jvm.internal.impl.load.kotlin.header.*;
import kotlin.reflect.jvm.internal.impl.metadata.*;
import kotlin.reflect.jvm.internal.impl.metadata.builtins.*;
import kotlin.reflect.jvm.internal.impl.metadata.deserialization.*;
import kotlin.reflect.jvm.internal.impl.metadata.jvm.*;
import kotlin.reflect.jvm.internal.impl.metadata.jvm.deserialization.*;
import kotlin.reflect.jvm.internal.impl.name.*;
import kotlin.reflect.jvm.internal.impl.platform.*;
import kotlin.reflect.jvm.internal.impl.protobuf.*;
import kotlin.reflect.jvm.internal.impl.renderer.*;
import kotlin.reflect.jvm.internal.impl.resolve.*;
import kotlin.reflect.jvm.internal.impl.resolve.calls.inference.*;
import kotlin.reflect.jvm.internal.impl.resolve.constants.*;
import kotlin.reflect.jvm.internal.impl.resolve.descriptorUtil.*;
import kotlin.reflect.jvm.internal.impl.resolve.jvm.*;
import kotlin.reflect.jvm.internal.impl.resolve.scopes.*;
import kotlin.reflect.jvm.internal.impl.resolve.scopes.receivers.*;
import kotlin.reflect.jvm.internal.impl.serialization.*;
import kotlin.reflect.jvm.internal.impl.serialization.deserialization.*;
import kotlin.reflect.jvm.internal.impl.serialization.deserialization.descriptors.*;
import kotlin.reflect.jvm.internal.impl.storage.*;
import kotlin.reflect.jvm.internal.impl.types.*;
import kotlin.reflect.jvm.internal.impl.types.checker.*;
import kotlin.reflect.jvm.internal.impl.types.error.*;
import kotlin.reflect.jvm.internal.impl.types.typeUtil.*;
import kotlin.reflect.jvm.internal.impl.types.typesApproximation.*;
import kotlin.reflect.jvm.internal.impl.util.*;
import kotlin.reflect.jvm.internal.impl.util.capitalizeDecapitalize.*;
import kotlin.reflect.jvm.internal.impl.util.collectionUtils.*;
import kotlin.reflect.jvm.internal.impl.utils.*;
import kotlin.reflect.jvm.internal.pcollections.*;
import kotlin.reflect.jvm.internal.structure.*;
import com.github.thomasnield.rxkotlinfx.*;
import io.reactivex.rxjavafx.observables.*;
import io.reactivex.rxjavafx.sources.*;
import io.reactivex.rxjavafx.observers.*;
import io.reactivex.rxjavafx.schedulers.*;
import io.reactivex.rxjavafx.subscriptions.*;
import io.reactivex.rxjavafx.transformers.*;
import io.reactivex.*;
import io.reactivex.parallel.*;
import io.reactivex.processors.*;
import io.reactivex.exceptions.*;
import io.reactivex.disposables.*;
import io.reactivex.subjects.*;
import io.reactivex.internal.fuseable.*;
import io.reactivex.internal.disposables.*;
import io.reactivex.internal.subscriptions.*;
import io.reactivex.internal.observers.*;
import io.reactivex.internal.operators.maybe.*;
import io.reactivex.internal.operators.parallel.*;
import io.reactivex.internal.operators.completable.*;
import io.reactivex.internal.operators.single.*;
import io.reactivex.internal.operators.observable.*;
import io.reactivex.internal.operators.flowable.*;
import io.reactivex.internal.subscribers.*;
import io.reactivex.internal.queue.*;
import io.reactivex.internal.functions.*;
import io.reactivex.internal.schedulers.*;
import io.reactivex.internal.util.*;
import io.reactivex.observers.*;
import io.reactivex.subscribers.*;
import io.reactivex.annotations.*;
import io.reactivex.plugins.*;
import io.reactivex.functions.*;
import io.reactivex.schedulers.*;
import io.reactivex.flowables.*;
import io.reactivex.observables.*;
import org.reactivestreams.*;
import com.beust.klaxon.*;
import com.beust.klaxon.token.*;
import com.beust.klaxon.internal.*;
import org.mistutils.raster.*;
import org.mistutils.raster.multi.*;
import org.mistutils.random.*;
import org.mistutils.classes.*;
import org.mistutils.color.colorspace.*;
import org.mistutils.color.*;
import org.mistutils.color.colortype.*;
import org.mistutils.geometry.int3.*;
import org.mistutils.geometry.double2.*;
import org.mistutils.geometry.double3.*;
import org.mistutils.geometry.rectangle.*;
import org.mistutils.geometry.volume.*;
import org.mistutils.geometry.intvolume.*;
import org.mistutils.geometry.int2.*;
import org.mistutils.geometry.grid.*;
import org.mistutils.collections.map2d.*;
import org.mistutils.collections.*;
import org.mistutils.collections.space.*;
import org.mistutils.collections.bag.*;
import org.mistutils.collections.ringbuffer.*;
import org.mistutils.logic.*;
import org.mistutils.files.*;
import org.mistutils.strings.*;
import org.mistutils.checking.*;
import org.mistutils.symbol.*;
import org.mistutils.lang.*;
import org.mistutils.lang.serialization.*;
import org.mistutils.lang.tweakfun.*;
import org.mistutils.lang.tweakfun.functions.*;
import org.mistutils.ui.*;
import org.mistutils.updating.*;
import org.mistutils.updating.strategies.*;
import org.mistutils.field.*;
import org.mistutils.field.featurefields.*;
import org.mistutils.field.featurefields.typestrategies.*;
import org.mistutils.field.featurefields.placementstrategies.*;
import org.mistutils.field.valuefields.*;
import org.mistutils.field.valuefields.sampling.*;
import org.mistutils.field.objectfields.*;
import org.mistutils.service.*;
import org.mistutils.time.*;
import org.mistutils.varying.*;
import org.mistutils.interpolation.interpolators.*;
import org.mistutils.interpolation.mixers.*;
import org.mistutils.interpolation.*;
import org.mistutils.interpolation.gradient.*;
import org.mistutils.math.*;
import org.mistutils.properties.*;
import org.mistutils.noise.*;
import impl.org.controlsfx.autocompletion.*;
import impl.org.controlsfx.behavior.*;
import impl.org.controlsfx.i18n.*;
import impl.org.controlsfx.*;
import impl.org.controlsfx.skin.*;
import impl.org.controlsfx.spreadsheet.*;
import impl.org.controlsfx.table.*;
import impl.org.controlsfx.tools.*;
import impl.org.controlsfx.tools.rectangle.change.*;
import impl.org.controlsfx.tools.rectangle.*;
import impl.org.controlsfx.version.*;
import impl.org.controlsfx.worldmap.*;
import org.controlsfx.control.action.*;
import org.controlsfx.control.*;
import org.controlsfx.control.cell.*;
import org.controlsfx.control.decoration.*;
import org.controlsfx.control.spreadsheet.*;
import org.controlsfx.control.table.model.*;
import org.controlsfx.control.table.*;
import org.controlsfx.control.textfield.*;
import org.controlsfx.dialog.*;
import org.controlsfx.glyphfont.*;
import org.controlsfx.property.*;
import org.controlsfx.property.editor.*;
import org.controlsfx.tools.*;
import org.controlsfx.validation.decoration.*;
import org.controlsfx.validation.*;
import org.hsluv.*;
import com.koloboke.collect.*;
import com.koloboke.collect.hash.*;
import com.koloboke.collect.map.*;
import com.koloboke.collect.map.hash.*;
import com.koloboke.collect.set.*;
import com.koloboke.collect.set.hash.*;
import com.koloboke.function.*;
import com.koloboke.collect.impl.*;
import com.koloboke.collect.impl.hash.*;
import org.demotweaker.*;
import org.demotweaker.ui.*;

import kotlin.collections.*;
import kotlin.jvm.internal.*;
import kotlin.coroutines.*;
import kotlin.coroutines.intrinsics.*;
import kotlin.coroutines.jvm.internal.*;
import kotlin.*;
import kotlin.io.*;
import kotlin.internal.*;
import kotlin.random.*;
import kotlin.js.*;
import kotlin.reflect.*;
import kotlin.jvm.*;
import kotlin.jvm.internal.markers.*;
import kotlin.jvm.internal.unsafe.*;
import kotlin.jvm.functions.*;
import kotlin.system.*;
import kotlin.contracts.*;
import kotlin.sequences.*;
import kotlin.comparisons.*;
import kotlin.text.*;
import kotlin.experimental.*;
import kotlin.concurrent.*;
import kotlin.properties.*;
import kotlin.annotation.*;
import kotlin.ranges.*;
import kotlin.math.*;
import kotlin.coroutines.experimental.*;
import kotlin.coroutines.experimental.intrinsics.*;
import kotlin.coroutines.experimental.migration.*;
import kotlin.coroutines.experimental.jvm.internal.*;
import org.intellij.lang.annotations.*;
import org.jetbrains.annotations.*;
import tornadofx.adapters.*;
import tornadofx.*;
import tornadofx.osgi.*;
import sun.net.www.protocol.css.*;
import tornadofx.osgi.impl.*;
import org.glassfish.json.*;
import org.glassfish.json.api.*;
import javax.json.*;
import javax.json.spi.*;
import javax.json.stream.*;
import kotlin.internal.jdk8.*;
import kotlin.text.jdk8.*;
import kotlin.collections.jdk8.*;
import kotlin.streams.jdk8.*;
import kotlin.internal.jdk7.*;
import kotlin.jdk7.*;
import kotlin.reflect.full.*;
import kotlin.reflect.jvm.*;
import kotlin.reflect.jvm.internal.*;
import kotlin.reflect.jvm.internal.components.*;
import kotlin.reflect.jvm.internal.impl.builtins.*;
import kotlin.reflect.jvm.internal.impl.builtins.functions.*;
import kotlin.reflect.jvm.internal.impl.descriptors.*;
import kotlin.reflect.jvm.internal.impl.descriptors.annotations.*;
import kotlin.reflect.jvm.internal.impl.descriptors.deserialization.*;
import kotlin.reflect.jvm.internal.impl.descriptors.impl.*;
import kotlin.reflect.jvm.internal.impl.incremental.*;
import kotlin.reflect.jvm.internal.impl.incremental.components.*;
import kotlin.reflect.jvm.internal.impl.load.java.*;
import kotlin.reflect.jvm.internal.impl.load.java.components.*;
import kotlin.reflect.jvm.internal.impl.load.java.descriptors.*;
import kotlin.reflect.jvm.internal.impl.load.java.lazy.*;
import kotlin.reflect.jvm.internal.impl.load.java.lazy.descriptors.*;
import kotlin.reflect.jvm.internal.impl.load.java.lazy.types.*;
import kotlin.reflect.jvm.internal.impl.load.java.sources.*;
import kotlin.reflect.jvm.internal.impl.load.java.structure.*;
import kotlin.reflect.jvm.internal.impl.load.java.typeEnhancement.*;
import kotlin.reflect.jvm.internal.impl.load.kotlin.*;
import kotlin.reflect.jvm.internal.impl.load.kotlin.header.*;
import kotlin.reflect.jvm.internal.impl.metadata.*;
import kotlin.reflect.jvm.internal.impl.metadata.builtins.*;
import kotlin.reflect.jvm.internal.impl.metadata.deserialization.*;
import kotlin.reflect.jvm.internal.impl.metadata.jvm.*;
import kotlin.reflect.jvm.internal.impl.metadata.jvm.deserialization.*;
import kotlin.reflect.jvm.internal.impl.name.*;
import kotlin.reflect.jvm.internal.impl.platform.*;
import kotlin.reflect.jvm.internal.impl.protobuf.*;
import kotlin.reflect.jvm.internal.impl.renderer.*;
import kotlin.reflect.jvm.internal.impl.resolve.*;
import kotlin.reflect.jvm.internal.impl.resolve.calls.inference.*;
import kotlin.reflect.jvm.internal.impl.resolve.constants.*;
import kotlin.reflect.jvm.internal.impl.resolve.descriptorUtil.*;
import kotlin.reflect.jvm.internal.impl.resolve.jvm.*;
import kotlin.reflect.jvm.internal.impl.resolve.scopes.*;
import kotlin.reflect.jvm.internal.impl.resolve.scopes.receivers.*;
import kotlin.reflect.jvm.internal.impl.serialization.*;
import kotlin.reflect.jvm.internal.impl.serialization.deserialization.*;
import kotlin.reflect.jvm.internal.impl.serialization.deserialization.descriptors.*;
import kotlin.reflect.jvm.internal.impl.storage.*;
import kotlin.reflect.jvm.internal.impl.types.*;
import kotlin.reflect.jvm.internal.impl.types.checker.*;
import kotlin.reflect.jvm.internal.impl.types.error.*;
import kotlin.reflect.jvm.internal.impl.types.typeUtil.*;
import kotlin.reflect.jvm.internal.impl.types.typesApproximation.*;
import kotlin.reflect.jvm.internal.impl.util.*;
import kotlin.reflect.jvm.internal.impl.util.capitalizeDecapitalize.*;
import kotlin.reflect.jvm.internal.impl.util.collectionUtils.*;
import kotlin.reflect.jvm.internal.impl.utils.*;
import kotlin.reflect.jvm.internal.pcollections.*;
import kotlin.reflect.jvm.internal.structure.*;
import com.github.thomasnield.rxkotlinfx.*;
import io.reactivex.rxjavafx.observables.*;
import io.reactivex.rxjavafx.sources.*;
import io.reactivex.rxjavafx.observers.*;
import io.reactivex.rxjavafx.schedulers.*;
import io.reactivex.rxjavafx.subscriptions.*;
import io.reactivex.rxjavafx.transformers.*;
import io.reactivex.*;
import io.reactivex.parallel.*;
import io.reactivex.processors.*;
import io.reactivex.exceptions.*;
import io.reactivex.disposables.*;
import io.reactivex.subjects.*;
import io.reactivex.internal.fuseable.*;
import io.reactivex.internal.disposables.*;
import io.reactivex.internal.subscriptions.*;
import io.reactivex.internal.observers.*;
import io.reactivex.internal.operators.maybe.*;
import io.reactivex.internal.operators.parallel.*;
import io.reactivex.internal.operators.completable.*;
import io.reactivex.internal.operators.single.*;
import io.reactivex.internal.operators.observable.*;
import io.reactivex.internal.operators.flowable.*;
import io.reactivex.internal.subscribers.*;
import io.reactivex.internal.queue.*;
import io.reactivex.internal.functions.*;
import io.reactivex.internal.schedulers.*;
import io.reactivex.internal.util.*;
import io.reactivex.observers.*;
import io.reactivex.subscribers.*;
import io.reactivex.annotations.*;
import io.reactivex.plugins.*;
import io.reactivex.functions.*;
import io.reactivex.schedulers.*;
import io.reactivex.flowables.*;
import io.reactivex.observables.*;
import org.reactivestreams.*;
import com.beust.klaxon.*;
import com.beust.klaxon.token.*;
import com.beust.klaxon.internal.*;
import org.mistutils.raster.*;
import org.mistutils.raster.multi.*;
import org.mistutils.random.*;
import org.mistutils.classes.*;
import org.mistutils.color.colorspace.*;
import org.mistutils.color.*;
import org.mistutils.color.colortype.*;
import org.mistutils.geometry.int3.*;
import org.mistutils.geometry.double2.*;
import org.mistutils.geometry.double3.*;
import org.mistutils.geometry.rectangle.*;
import org.mistutils.geometry.volume.*;
import org.mistutils.geometry.intvolume.*;
import org.mistutils.geometry.int2.*;
import org.mistutils.geometry.grid.*;
import org.mistutils.collections.map2d.*;
import org.mistutils.collections.*;
import org.mistutils.collections.space.*;
import org.mistutils.collections.bag.*;
import org.mistutils.collections.ringbuffer.*;
import org.mistutils.logic.*;
import org.mistutils.files.*;
import org.mistutils.strings.*;
import org.mistutils.checking.*;
import org.mistutils.symbol.*;
import org.mistutils.lang.*;
import org.mistutils.lang.serialization.*;
import org.mistutils.lang.tweakfun.*;
import org.mistutils.lang.tweakfun.functions.*;
import org.mistutils.ui.*;
import org.mistutils.updating.*;
import org.mistutils.updating.strategies.*;
import org.mistutils.field.*;
import org.mistutils.field.featurefields.*;
import org.mistutils.field.featurefields.typestrategies.*;
import org.mistutils.field.featurefields.placementstrategies.*;
import org.mistutils.field.valuefields.*;
import org.mistutils.field.valuefields.sampling.*;
import org.mistutils.field.objectfields.*;
import org.mistutils.service.*;
import org.mistutils.time.*;
import org.mistutils.varying.*;
import org.mistutils.interpolation.interpolators.*;
import org.mistutils.interpolation.mixers.*;
import org.mistutils.interpolation.*;
import org.mistutils.interpolation.gradient.*;
import org.mistutils.math.*;
import org.mistutils.properties.*;
import org.mistutils.noise.*;
import impl.org.controlsfx.autocompletion.*;
import impl.org.controlsfx.behavior.*;
import impl.org.controlsfx.i18n.*;
import impl.org.controlsfx.*;
import impl.org.controlsfx.skin.*;
import impl.org.controlsfx.spreadsheet.*;
import impl.org.controlsfx.table.*;
import impl.org.controlsfx.tools.*;
import impl.org.controlsfx.tools.rectangle.change.*;
import impl.org.controlsfx.tools.rectangle.*;
import impl.org.controlsfx.version.*;
import impl.org.controlsfx.worldmap.*;
import org.controlsfx.control.action.*;
import org.controlsfx.control.*;
import org.controlsfx.control.cell.*;
import org.controlsfx.control.decoration.*;
import org.controlsfx.control.spreadsheet.*;
import org.controlsfx.control.table.model.*;
import org.controlsfx.control.table.*;
import org.controlsfx.control.textfield.*;
import org.controlsfx.dialog.*;
import org.controlsfx.glyphfont.*;
import org.controlsfx.property.*;
import org.controlsfx.property.editor.*;
import org.controlsfx.tools.*;
import org.controlsfx.validation.decoration.*;
import org.controlsfx.validation.*;
import org.hsluv.*;
import com.koloboke.collect.*;
import com.koloboke.collect.hash.*;
import com.koloboke.collect.map.*;
import com.koloboke.collect.map.hash.*;
import com.koloboke.collect.set.*;
import com.koloboke.collect.set.hash.*;
import com.koloboke.function.*;
import com.koloboke.collect.impl.*;
import com.koloboke.collect.impl.hash.*;
import org.demotweaker.*;
import org.demotweaker.ui.*;


Tweaker tweaker;
Terrain castleHill;
Terrain bgHill1;
Terrain bgHill2;
Ivy ivy1;
//Ivy ivy2;
Ivy ivy3;
Ivy ivy4;
Ivy ivy5;
VoxelCastle castle;
ActionCam camera;

Variable fade;

String MUSIC_FILE = "Majestic Hills.mp3";

String credits = 
  "Forest Ivy Castle\n" +
  "\n" +
  "by GeoScapers\n" +
  "for Graffathon 2019\n" +
  "\n" +
  "  Ivy by:         shiera\n" +
  "  Castle by:      fractalpixel\n" +
  "  Background by:  sierrafox\n" +
  "\n" +
  "Music: \"Majestic Hills\"\n" + 
  "  by: Kevin MacLeod:\n" +
  "  cc-by\n";

float DEMO_LENGTH_SECONDS = 199;
float BEATS_PER_MINUTE = 68;

Minim minim;
AudioPlayer audioPlayer;

void setup() {
  randomSeed(42);
  noiseSeed(5);

  tweaker = new Tweaker(dataPath("tweakerSettings.json"), DEMO_LENGTH_SECONDS, BEATS_PER_MINUTE / 60.0f);
  fade = tweaker.variable("fade", 1.0);

  minim = new Minim(this);
  audioPlayer = minim.loadFile(MUSIC_FILE); // Load music from data directory  


  camera = new ActionCam(tweaker);

  // Setup hue saturation brightness based colors
  colorMode(HSB, 100f, 100f, 100f);


  // size(1600, 900, P3D);
  //size(800, 450, P3D);
  size(1067, 600, P3D);

  castleHill = new Terrain(7, 0.005, 0.5, -30, 2, true);
  bgHill1 = new Terrain(13, 0.0026, 0.000015, -135, 5, false);
  bgHill2 = new Terrain(25, 0.0008, 0.0005, -150, 9, false);


  ivy1 =  new Ivy(new PVector(0, 3, 0), new PVector(0, -1, 0));
  // ivy2 =  new Ivy(new PVector(20,15,10), new PVector(0,-1, 0));
  ivy3 =  new Ivy(new PVector(-30, 15, 0), new PVector(0, -1, 0));
  ivy4 =  new Ivy(new PVector(-10, 15, -30), new PVector(0, -1, 0));
  ivy5 =  new Ivy(new PVector(10, 15, 33), new PVector(0, -1, 0));

  //  size(1600, 900, P3D);


  castle = new VoxelCastle(0.9f, -10, -15, 0, 653);

  setupStars();

  tweaker.openEditor();

  // No lines between polygons
  noStroke();
  fill(80);

  // Start playing music
  audioPlayer.play();
}


void draw() {
  // Center screen
  translate(width/2f, height/2f);
  scale(height/100.0);

  tweaker.update();


  // Clear to black
  background(50, 20, 70);
  
  drawSky();


  camera.update();


  // Setup lights
  directionalLight(80, 30, 30, 0.2, 0.2, 0.1);
  directionalLight(13, 20, 80, -0.5, 0.8, 0.1);
  //  directionalLight(20, 20, 100, 0.2, -0.3, -0.3);
  ambientLight(70, 20, 40);

  pushMatrix();
  castleHill.draw();
  popMatrix();

  pushMatrix();
  translate(0, 90, 0);
  bgHill1.draw();
  bgHill2.draw();
  popMatrix();

  // Calibration sphere
  /*
  pushMatrix();
   noStroke();
   translate(40, 0, 0);
   //translate(0f, 0f, 100f);
   fill(0f, 20f, 40f);
   sphere(30);
   popMatrix();
   */


  pushMatrix();
  ivy1.drawIvy();
  // ivy2.drawIvy();
  ivy3.drawIvy();
  ivy4.drawIvy();
  ivy5.drawIvy();
  popMatrix();

  //if (secondsFromStart() > 60) castle.draw();
  castle.draw();

  // Check for end
  if (tweaker.getTime().getCurrentStepElapsedSeconds() > DEMO_LENGTH_SECONDS) {
    // Time to quit
    exit();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  camera.changeDistance(e * 10f);
}
